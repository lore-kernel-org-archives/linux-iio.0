Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC326B755
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097052; cv=none; b=EJhONnYdtpk/KfF6qUEhMREkNVp/R/DQ2NpIXzjQCGHmhE/3kfDcBg114WcCVlyxiayh+FfGAznnVJhAVunGPcOL00QsSPWmcQkouWq5MxIHdDPuUOcaSXgycnIeA98bzKcd9NC59AOQUe0bzXtn2tAyksv2hx6l5jYN4GOv3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097052; c=relaxed/simple;
	bh=a/ZA6sjCUKqdxw4wvPaq8Dxh7KaTwJBXVARu4Bv36rM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4cFEJ5xhoJgLVtqWYZ6/rs2fR8EX4kzq5JIbgpRlLSmxolFPD4GixG0nZOW6aYMKesna3CNHc+VkKVPSGgFn78fIH7XBwZd8hAEwSTbf7NnU9Os9zWRNqq+VLbPIn4yCeeV109JOlvKS3J+Dvu76Jzkmpu32Kg475n78rKDTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSaAqaA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSaAqaA9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3A2AC19425
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771097051;
	bh=a/ZA6sjCUKqdxw4wvPaq8Dxh7KaTwJBXVARu4Bv36rM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RSaAqaA9+wuOYD5aSG6KmAt7Flre3rEsX/BayAy1X1eQjbAnSc+Yb+jPePqq66bid
	 Y7ewg/MEzWUxGS8CMC+9fIm8BTIJASwFoATMs80g6rH7Qg9QYcQ9roa9PNTXp3fgeB
	 aXld958Pr0WMjy8EfSVgKzBpYIqVtFDxRGRdXJ/EJgDfh4ZnifGMewuUnaob2R4/Mk
	 jfAZVoTAPCjs3u4puavCp9neY7uQFqK9Qa+C22fzL4js0pz801DT1mesH+GPraLtBP
	 p3eN6+XwPkUf8FzH4wJqkJKZvg3UI4quv5iyxk7yh6SX3obIm+W84skEDmNjCpqUgJ
	 IaNY1+k+ZRLeA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B8166C53BC9; Sat, 14 Feb 2026 19:24:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] [iio] [hid-sensor-rotation] Memory corruption due to
 alignment mismatch in scan buffer
Date: Sat, 14 Feb 2026 19:24:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221077-217253-qbnh7eccIv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221077-217253@https.bugzilla.kernel.org/>
References: <bug-221077-217253@https.bugzilla.kernel.org/>
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

--- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
On Wed, 11 Feb 2026 05:12:36 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D221077
>=20
>             Bug ID: 221077
>            Summary: [iio] [hid-sensor-rotation] Memory corruption due to
>                     alignment mismatch in scan buffer
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: lixu.zhang@intel.com
>         Regression: Yes
>            Bisected b31a74075cb4ca2bb202a2e17d133ef3c9ee891f
>          commit-id:
>=20
> ### Problem
> In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_decml`=
 and
> `scale_post_decml` fields in `struct dev_rot_state` get corrupted after t=
he
> first read from the device. This issue results in invalid scale values be=
ing
> reported to userspace.
>=20
> ### Root Cause Analysis
> The issue is caused by a size mismatch between what the IIO core expects =
for
> the scan buffer and the actual size of the driver's scan structure.
>=20
> 1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consists o=
f a
> quaternion (4 * s32 =3D 16 bytes) and a timestamp (8 bytes).
>     ```c
>     struct {
>             s32 sampled_vals[4];
>             aligned_s64 timestamp;
>     } scan;
>     ```
>     Without explicit alignment, this structure is packed to **24 bytes**.

I agree it's 24 bytes, but worth being clear it has explicit alignment to 8
bytes. Without that on some platforms it would be 4 byte aligned only.

>=20
> 2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function
> calculates
> the buffer size required. It aligns the total size to the size of the
> *largest
> element* in the scan.
>     - The quaternion channel is treated as a single 16-byte element.
>     - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24, 1=
6) =3D
> 32 bytes`.

Ah. That is indeed a corner case and the ABI is IIRC not well documented
around that, let alone what we do in the kernel. We probably need to tighten
that
up as well as fixing this. What userspace were you using to test this?


>=20
> 3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is called:
>     - It assumes a 32-byte buffer.
>     - It writes the timestamp at the end of the aligned buffer (offset 24=
).
>     - Since the driver allocated only 24 bytes for `scan`, the write at
>     offset
> 24 overwrites the adjacent `scale_pre_decml` field in `struct dev_rot_sta=
te`.
>=20
> ### Evidence (Ftrace)
> I verified this by tracing the return values of `iio_storage_bytes_for_si`
> and
> `iio_compute_scan_bytes` using kretprobes:
>=20
> ```log
> $ cat /sys/kernel/tracing/trace_pipe
> r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
> iio_storage_bytes_for_si) arg1=3D0x10
> r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
> iio_storage_bytes_for_si) arg1=3D0x8
> r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
> iio_compute_scan_bytes) arg1=3D0x20
> ```
>=20
> The trace confirms:
> - Largest element =3D 16 bytes.
> - Total raw size =3D 16 (quat) + 8 (ts) =3D 24 bytes.
> - Final aligned size =3D ALIGN(24, 16) =3D 32 bytes.
>=20
> The memory layout mismatch is:
> - IIO Core needs: 32 bytes
> - Driver struct has: 24 bytes
>=20
> ### Regression
> This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
> hid-sensor-rotation: remove unnecessary alignment")`, which removed the
> `__aligned(16)` attribute that previously ensured the struct was padded t=
o 32
> bytes.
>=20
> ### Proposed Fix
> Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state` has
> the
> correct padding to match the IIO core's expectations.
>=20
> ```c
> struct {
>         s32 sampled_vals[4] __aligned(16);
Agreed that fix is correct.
However, we definitely also need to add some documentation on why it is the=
re.

It's not actually an alignment force on sampled_vals, but rather on the
timestamp.
We can't just mark the timestamp as then it will have two aligned markings =
on
x86_32.

David, given we both missed this when 'tidying' this up wrongly what do you
think
would make this clearest?


Thanks for reporting this with such a thorough and detailed investigation!
Makes our lives a lot easier.

Jonathan

>         aligned_s64 timestamp;
> } scan;
> ```
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
