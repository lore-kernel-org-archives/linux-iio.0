Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827226B755
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097051; cv=none; b=bHRURzy8BJaO4qjSuJk1ji35ZsrxrX+2Z0iqULldE2Cm8obO8ilvAd4RUceoqyWGr3ixTl7bEyELBF1W2aR+0ls9mnVQk/A5xaJipfUNknt0qYK1XNftlvaQnXw6RBdK+5XoEBW0/BjmqeDUxDV52J/4EGwvlpzgmctOKbtlRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097051; c=relaxed/simple;
	bh=UrFrKyQSCGxJDyh/pRDpe8TT1Nz9/eC0gcJxZgKi/Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaAl4bLTIICfj0HkrNu85bAM1GyC+ih960TnljUKavsafhUmFM41B4yvO+xDjtL3oPFI9VOKcTOBrV46B0zvpOI8GiX0YOxY/NSRQjvXa8uogMoVXxpSVo2OaPwCObDrSKsdktU5rmGmOONE3Da253SjmfMNm7te0zVqkCwAh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLaU7mi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLaU7mi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B8C16AAE;
	Sat, 14 Feb 2026 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771097050;
	bh=UrFrKyQSCGxJDyh/pRDpe8TT1Nz9/eC0gcJxZgKi/Cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLaU7mi3TngZVPOq1KUuAdv8i4sVyDM/2ggsQIiQg9KSDnG9vyuofoDFgyPhYEDAM
	 4lnJd4IrdgwaMgiyWb9ZO/93CCT4YCEkK6+FncAfuPgl2qe/AkqGEj8xSsHDeFqdqE
	 GSnQQ0i+D5vR5pCqUMhc+0TFIJJU7AlNt2+47SY94Rh9PlwkJX5wcEAdNgk05Wp83b
	 QF6JjBWBum//tBoZouizlh1F7L4GabKaKi7pKdtxQDWCgznpFvZfSJ9Baxj1u2+A0P
	 NcEA4Oklew2as93ZrYz0+gVHG2St/pcLoqNlmPMu46xsrBP8tSnr9LRFl+0K4TT+nL
	 Lik4rjsmhhqVQ==
Date: Sat, 14 Feb 2026 19:24:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [Bug 221077] New: [iio] [hid-sensor-rotation] Memory corruption
 due to alignment mismatch in scan buffer
Message-ID: <20260214192404.1240b351@jic23-huawei>
In-Reply-To: <bug-221077-217253@https.bugzilla.kernel.org/>
References: <bug-221077-217253@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 05:12:36 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=221077
> 
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
> 
> ### Problem
> In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_decml` and
> `scale_post_decml` fields in `struct dev_rot_state` get corrupted after the
> first read from the device. This issue results in invalid scale values being
> reported to userspace.
> 
> ### Root Cause Analysis
> The issue is caused by a size mismatch between what the IIO core expects for
> the scan buffer and the actual size of the driver's scan structure.
> 
> 1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consists of a
> quaternion (4 * s32 = 16 bytes) and a timestamp (8 bytes).
>     ```c
>     struct {
>             s32 sampled_vals[4];
>             aligned_s64 timestamp;
>     } scan;
>     ```
>     Without explicit alignment, this structure is packed to **24 bytes**.

I agree it's 24 bytes, but worth being clear it has explicit alignment to 8
bytes. Without that on some platforms it would be 4 byte aligned only.

> 
> 2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function calculates
> the buffer size required. It aligns the total size to the size of the *largest
> element* in the scan.
>     - The quaternion channel is treated as a single 16-byte element.
>     - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24, 16) =
> 32 bytes`.

Ah. That is indeed a corner case and the ABI is IIRC not well documented
around that, let alone what we do in the kernel. We probably need to tighten that
up as well as fixing this. What userspace were you using to test this?


> 
> 3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is called:
>     - It assumes a 32-byte buffer.
>     - It writes the timestamp at the end of the aligned buffer (offset 24).
>     - Since the driver allocated only 24 bytes for `scan`, the write at offset
> 24 overwrites the adjacent `scale_pre_decml` field in `struct dev_rot_state`.
> 
> ### Evidence (Ftrace)
> I verified this by tracing the return values of `iio_storage_bytes_for_si` and
> `iio_compute_scan_bytes` using kretprobes:
> 
> ```log
> $ cat /sys/kernel/tracing/trace_pipe
> r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
> iio_storage_bytes_for_si) arg1=0x10
> r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
> iio_storage_bytes_for_si) arg1=0x8
> r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
> iio_compute_scan_bytes) arg1=0x20
> ```
> 
> The trace confirms:
> - Largest element = 16 bytes.
> - Total raw size = 16 (quat) + 8 (ts) = 24 bytes.
> - Final aligned size = ALIGN(24, 16) = 32 bytes.
> 
> The memory layout mismatch is:
> - IIO Core needs: 32 bytes
> - Driver struct has: 24 bytes
> 
> ### Regression
> This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
> hid-sensor-rotation: remove unnecessary alignment")`, which removed the
> `__aligned(16)` attribute that previously ensured the struct was padded to 32
> bytes.
> 
> ### Proposed Fix
> Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state` has the
> correct padding to match the IIO core's expectations.
> 
> ```c
> struct {
>         s32 sampled_vals[4] __aligned(16);
Agreed that fix is correct.
However, we definitely also need to add some documentation on why it is there.

It's not actually an alignment force on sampled_vals, but rather on the timestamp.
We can't just mark the timestamp as then it will have two aligned markings on x86_32.

David, given we both missed this when 'tidying' this up wrongly what do you think
would make this clearest?


Thanks for reporting this with such a thorough and detailed investigation!
Makes our lives a lot easier.

Jonathan

>         aligned_s64 timestamp;
> } scan;
> ```
> 

