# EASFP_flash_i2c_cpp — ADuCM410 I2C flasher (Linux)

Repo: `~/Workspace/EASFP_flash_i2c_cpp` (iPronics GitHub). Explored 2026-10-05.

## What it is
Host-side C++17 CLI (`aducm410_flasher`) that flashes an ADuCM410 over I2C using the
Analog Devices loader protocol (AN-806). Parses an Intel HEX file into 8 KiB pages,
then erase → write → verify (2-step, CRC-24 page signature) → optional run. (verified, source)

- Build: CMake, `-Wall -Wextra -Wpedantic`; CLI11 as submodule in `third_party/`. (verified, CMakeLists.txt)
- `i2c_ftdi_class.*` exists but is **not** in the build. (verified, CMakeLists.txt)
- I2C transport: `I2cLinux` (i2c-dev) behind the `I2cHostBase` interface. 7-bit address 0x02. (verified, source)

## Protocol facts checked against AN-806 (Documentation/AN-806_Rev._PrI.pdf)
- Table 12, status byte: bit0 Timeout, bit1 Checksum, bit2 KeyError, bit3 Swap,
  bit4 Swap0, bit5 Swap1, bit6 Reserved, bit7 Valid. The code mapping is wrong (Review-001). (verified, PDF)
- Table 3 lists ACK/BEL as responses to Run. Whether the loader sends it before resetting: not verified.

## Review workflow (project skill `/ipronics-code-review`)
- Two reports at repo root: `review_report_open.md` (source of truth for status) and
  `review_report_history.md` (resolved). Inline one-line `[Status][Review-NNN]...` markers.
- Vicente moves a finding forward by editing **Status** in the report (ToCheck / Replied / ToDo);
  the follow-up pass syncs the inline tag and verifies.
- The pre-commit guard that blocks `[Pending]` markers is **not installed** in this repo (Vicente's choice).
  Review work lives on its own branch so `feature/linux_flasher` stays clean.

## State (2026-10-05)
- First review: 26 findings, branch `feature/linux_flasher_review` @ `109200b` (pushed).
- An earlier manual review (2026-10-02) is in `ai/review.md`; several of its items were already
  fixed in commits a1dd0e6..538123e.
