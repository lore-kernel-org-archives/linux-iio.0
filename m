Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CD26290
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786757; cv=none; b=Tm7052PKzzPDeyl/Lv/mTCctWws5BKTZ59U9wmY3q0+ala0kV/cIQzMntKY8PUyzz+iggKd6CtTs8XdO0+F6AbXPaqGFYf9gmcD/ICkTTowoMQ0flCu1wOo+8CHDxt8ycoxb+cULWmnxaXH/GKaKB8OAuPpjgluxLSFnCATWfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786757; c=relaxed/simple;
	bh=QwpQm8wix04yr3v52+BxyQ6jLiG3vjJKPinGsaNCtFA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XDzzZLHqYH/NqFwLigLuOx4b0x3a+PrTUd/PIivU4pUIqurLoI+6/PmUcm4xTLvqLlsU8PmUGNarE++QBBeFrUJSHDzHg/eveT+0tYM1Z9lUYEbwCzsIoc0E/zJQliQBrTPi9hu29N26hObpdskYdd6GN2C/y0oZUCh4EaTZ9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoDb1Svy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoDb1Svy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DE37C4CEF7
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 05:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770786756;
	bh=QwpQm8wix04yr3v52+BxyQ6jLiG3vjJKPinGsaNCtFA=;
	h=From:To:Subject:Date:From;
	b=NoDb1SvyrdB5TKV6h6NTaDk9PkAs2mSWvHyxLfwRGiXv3Dl3gAgRppl7sVqHLakf8
	 juEgXIb5oD9pF0Ioy1bNR7JgbkYwZnT++myZ1TyZE+jVHkM6uVVk4d6bpl7H5yRN+p
	 druk6ehcl5ayoy8yWwr2YVV21xvYiydfbwYtxxlG/36/7dSO2VuWg2p987uwgaEmAC
	 MepT8bTfrMt61qpIKOBurw181k3KDVs0HoX/IYHzQzm+wRozy9BKK+CtMmOoxHDlZA
	 nJJCcBPj9+y8yS2ia5b/9eTJmf4DVi4MF3id8S6WytO4IFTeA2Y+so5J5KZ1P/ck6i
	 iRq7sWteJiZcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8CB68C4160E; Wed, 11 Feb 2026 05:12:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] New: [iio] [hid-sensor-rotation] Memory corruption due
 to alignment mismatch in scan buffer
Date: Wed, 11 Feb 2026 05:12:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lixu.zhang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression cf_bisect_commit
Message-ID: <bug-221077-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221077

            Bug ID: 221077
           Summary: [iio] [hid-sensor-rotation] Memory corruption due to
                    alignment mismatch in scan buffer
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: lixu.zhang@intel.com
        Regression: Yes
           Bisected b31a74075cb4ca2bb202a2e17d133ef3c9ee891f
         commit-id:

### Problem
In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_decml` a=
nd
`scale_post_decml` fields in `struct dev_rot_state` get corrupted after the
first read from the device. This issue results in invalid scale values being
reported to userspace.

### Root Cause Analysis
The issue is caused by a size mismatch between what the IIO core expects for
the scan buffer and the actual size of the driver's scan structure.

1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consists of a
quaternion (4 * s32 =3D 16 bytes) and a timestamp (8 bytes).
    ```c
    struct {
            s32 sampled_vals[4];
            aligned_s64 timestamp;
    } scan;
    ```
    Without explicit alignment, this structure is packed to **24 bytes**.

2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function calcula=
tes
the buffer size required. It aligns the total size to the size of the *larg=
est
element* in the scan.
    - The quaternion channel is treated as a single 16-byte element.
    - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24, 16)=
 =3D
32 bytes`.

3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is called:
    - It assumes a 32-byte buffer.
    - It writes the timestamp at the end of the aligned buffer (offset 24).
    - Since the driver allocated only 24 bytes for `scan`, the write at off=
set
24 overwrites the adjacent `scale_pre_decml` field in `struct dev_rot_state=
`.

### Evidence (Ftrace)
I verified this by tracing the return values of `iio_storage_bytes_for_si` =
and
`iio_compute_scan_bytes` using kretprobes:

```log
$ cat /sys/kernel/tracing/trace_pipe
r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
iio_storage_bytes_for_si) arg1=3D0x10
r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
iio_storage_bytes_for_si) arg1=3D0x8
r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
iio_compute_scan_bytes) arg1=3D0x20
```

The trace confirms:
- Largest element =3D 16 bytes.
- Total raw size =3D 16 (quat) + 8 (ts) =3D 24 bytes.
- Final aligned size =3D ALIGN(24, 16) =3D 32 bytes.

The memory layout mismatch is:
- IIO Core needs: 32 bytes
- Driver struct has: 24 bytes

### Regression
This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
hid-sensor-rotation: remove unnecessary alignment")`, which removed the
`__aligned(16)` attribute that previously ensured the struct was padded to =
32
bytes.

### Proposed Fix
Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state` has =
the
correct padding to match the IIO core's expectations.

```c
struct {
        s32 sampled_vals[4] __aligned(16);
        aligned_s64 timestamp;
} scan;
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
