Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94F25F994
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771100965; cv=none; b=TVKH/QnxbJKJdCsvbxLBCH466c6Kh7CHmMpYZUYp1n3xSv1NtJR25WzIhJv/xAC3IBbTQSMqrCj3pirMerr0Bsjs+024uCBELckNAW9MWLl8O+pA6drrJXwYyIvDlxep+wqJcRv/BNMxhO9zde91oMQa2AzdKZ629eYatYRiCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771100965; c=relaxed/simple;
	bh=+EqyIX9iAj1094StePok37n557Bp30wlF/2Wyls3O7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1LzhRhHFW20yse+UPGGj5tBZgV+dvUH9lsrccC2eJUq74jUaovLav1C1IhH+sMqDdGljjZYAAqS51XNShyrG3Vk7dcDrn+IlkJkpODdAFKlKXINGbf7YWoC2GYcdLpfOiHb0HFxrOvjL0csjHf23D0JPS1iOxQfx18LBZxr7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b7GScgV7; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b7GScgV7"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d19d3c7208so1331043a34.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 12:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771100961; x=1771705761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TXZevlCanmkwnLSXTt6QOkJ/KH1vvUHEW5MYnDq5vo=;
        b=b7GScgV7cIGsXEAYBRCueOU5x0RY2g/QKq+s3IMzEFb8gepD3AQX1xCsg/n2G8WL1k
         /XWQDJ3j4S5xe4jFzVPZ/DafhVLamB/QZRQbE9hbk3R62wdIhfpfv6MMXoC0Qa1/xrdT
         Nh2Qh16XiMdENkQcWj+pMbQl5Zud1nXu6sSkFWQOnNnixxnVaYvJNDvdyNmODsdQI/N6
         0yQIBQbbRj1MTXC5wv9YGEopHCWZlM08HNK/mIAdUZ9g95Bn4ZKMO+MGUMFxIBtSU+2d
         kqmUECh37rLLfZ42R1p0/3YRS0Eulj7CekHap9FbdjcMKTTqHYl1CWiSdhrwjBYUfd80
         kqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771100961; x=1771705761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TXZevlCanmkwnLSXTt6QOkJ/KH1vvUHEW5MYnDq5vo=;
        b=GGYHnH5w/8gc5v0IvIZsaSDMja/IZGVw8JvMtaWq7oD+pUASjHarqPwtMiMBUo5x3s
         kC97d1mDL4/jdfd1AP1hKHAHQjN/Ov+1jDzdCAbeajINCBr9MhCYoJfskwOTjjJLkUWH
         4YsEI0iw4BqVIrUUbBEt6B0VHIActetOWsFAvz9K15uKRXEvIBfihGfb5V3/sBeZFELf
         sONp7TJCFb8OIH3g/YI/XC+dPBqmaFBDyO9rCtylWg/1XyLWFtTEHJf4wgBZRAuWSGPT
         LE9VksRvO7qKIvYFGvWRtKz18QPfduAnsOtFlJC3zF2Buf+uL/vTWfHdSZSUqvnlNmhy
         QIQQ==
X-Gm-Message-State: AOJu0Yxhpal0iP766hYWPeKZVqk8wRFc5BKRUfCXsWqv71NzkvH5jLTB
	pWiSAvwVrMpqv5KIafe70iJiheywm6JH6NK9r/Oqm4JN2cclkQgi8V21m4T5wbC1rpT81XAtQkt
	CAtGd
X-Gm-Gg: AZuq6aJTWeriaHy/X3tvW0jgGLDKLae5eK1BqCrXODgiDbIdhRpWRiq7ZL5qPS6C4FV
	b+npgNGd5x9EQP5ueffu8FYbwhdJQ+cUd+5b16msJAKvCtuLTVKMQvVMremdEE/9m2ZT3S+Q8o3
	jmsx5fZbFfHkZMU0U1s0ZN9heLDsbb1/Wwli+T7ChFUWTRFclMbQ5HXyzrqy9pCyFfz1waDuf1c
	4vCdkmMhiD8d+FNJaiodO/t+0xTtwPm/T/DnsgoKqtA0rGMNo8yoDu8Chk523/+sFdRk599j0Q9
	CrF+cI/HoksffyQ11iwm3emwQHtiLfQ8txFMfyt89/Pfl7NjlRBdBQQnERrVZY4wnVgileFuWTS
	euuVE8tncZmLQhIG1ZlBIGRxLwnTqNprX9yqyKyS8cKfAF0JDKuH94rrC5DRNapn+BfIOYG8DZ8
	DLmLbUg4a+fYKjHByv8hzfre1tnP0ih5G0b6ZqrVp7lGQMZgxs0nQfxp08zQ2bQs1vo0LqeA==
X-Received: by 2002:a05:6808:2e48:b0:45e:8554:1f14 with SMTP id 5614622812f47-4639f294f41mr3282396b6e.59.1771100961545;
        Sat, 14 Feb 2026 12:29:21 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636ae8f86fsm7064645b6e.3.2026.02.14.12.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 12:29:21 -0800 (PST)
Message-ID: <b24cc218-1bb5-4272-8e44-054a983ec558@baylibre.com>
Date: Sat, 14 Feb 2026 14:29:19 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 221077] New: [iio] [hid-sensor-rotation] Memory corruption
 due to alignment mismatch in scan buffer
To: Jonathan Cameron <jic23@kernel.org>, bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
References: <bug-221077-217253@https.bugzilla.kernel.org/>
 <20260214192404.1240b351@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260214192404.1240b351@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/26 1:24 PM, Jonathan Cameron wrote:
> On Wed, 11 Feb 2026 05:12:36 +0000
> bugzilla-daemon@kernel.org wrote:
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=221077
>>
>>             Bug ID: 221077
>>            Summary: [iio] [hid-sensor-rotation] Memory corruption due to
>>                     alignment mismatch in scan buffer
>>            Product: Drivers
>>            Version: 2.5
>>           Hardware: All
>>                 OS: Linux
>>             Status: NEW
>>           Severity: normal
>>           Priority: P3
>>          Component: IIO
>>           Assignee: drivers_iio@kernel-bugs.kernel.org
>>           Reporter: lixu.zhang@intel.com
>>         Regression: Yes
>>            Bisected b31a74075cb4ca2bb202a2e17d133ef3c9ee891f
>>          commit-id:
>>
>> ### Problem
>> In `drivers/iio/orientation/hid-sensor-rotation.c`, the `scale_pre_decml` and
>> `scale_post_decml` fields in `struct dev_rot_state` get corrupted after the
>> first read from the device. This issue results in invalid scale values being
>> reported to userspace.
>>
>> ### Root Cause Analysis
>> The issue is caused by a size mismatch between what the IIO core expects for
>> the scan buffer and the actual size of the driver's scan structure.
>>
>> 1.  **Driver Structure**: The `scan` struct in `dev_rot_state` consists of a
>> quaternion (4 * s32 = 16 bytes) and a timestamp (8 bytes).
>>     ```c
>>     struct {
>>             s32 sampled_vals[4];
>>             aligned_s64 timestamp;
>>     } scan;
>>     ```
>>     Without explicit alignment, this structure is packed to **24 bytes**.
> 
> I agree it's 24 bytes, but worth being clear it has explicit alignment to 8
> bytes. Without that on some platforms it would be 4 byte aligned only.
> 
>>
>> 2.  **IIO Core Expectation**: The `iio_compute_scan_bytes` function calculates
>> the buffer size required. It aligns the total size to the size of the *largest
>> element* in the scan.
>>     - The quaternion channel is treated as a single 16-byte element.
>>     - Therefore, the core aligns the total size to 16 bytes: `ALIGN(24, 16) =
>> 32 bytes`.
> 
> Ah. That is indeed a corner case and the ABI is IIRC not well documented
> around that, let alone what we do in the kernel. We probably need to tighten that
> up as well as fixing this. What userspace were you using to test this?

I didn't even know we had IIO_MOD_QUATERNION as a special data type until
Francesco's recent patches. :-o

> 
> 
>>
>> 3.  **Corruption**: When `iio_push_to_buffers_with_timestamp()` is called:
>>     - It assumes a 32-byte buffer.
>>     - It writes the timestamp at the end of the aligned buffer (offset 24).
>>     - Since the driver allocated only 24 bytes for `scan`, the write at offset
>> 24 overwrites the adjacent `scale_pre_decml` field in `struct dev_rot_state`.
>>
>> ### Evidence (Ftrace)
>> I verified this by tracing the return values of `iio_storage_bytes_for_si` and
>> `iio_compute_scan_bytes` using kretprobes:
>>
>> ```log
>> $ cat /sys/kernel/tracing/trace_pipe
>> r_store_bytes: (iio_compute_scan_bytes+0x30/0xd0 [industrialio] <-
>> iio_storage_bytes_for_si) arg1=0x10
>> r_store_bytes: (iio_compute_scan_bytes+0xa1/0xd0 [industrialio] <-
>> iio_storage_bytes_for_si) arg1=0x8
>> r_calc_bytes: (__iio_update_buffers+0x99d/0xd40 [industrialio] <-
>> iio_compute_scan_bytes) arg1=0x20
>> ```
>>
>> The trace confirms:
>> - Largest element = 16 bytes.
>> - Total raw size = 16 (quat) + 8 (ts) = 24 bytes.
>> - Final aligned size = ALIGN(24, 16) = 32 bytes.
>>
>> The memory layout mismatch is:
>> - IIO Core needs: 32 bytes
>> - Driver struct has: 24 bytes
>>
>> ### Regression
>> This issue was introduced by commit `b31a74075cb4 ("iio: orientation:
>> hid-sensor-rotation: remove unnecessary alignment")`, which removed the
>> `__aligned(16)` attribute that previously ensured the struct was padded to 32
>> bytes.
>>
>> ### Proposed Fix
>> Revert the removal of `__aligned(16)` to ensure `struct dev_rot_state` has the
>> correct padding to match the IIO core's expectations.
>>
>> ```c
>> struct {
>>         s32 sampled_vals[4] __aligned(16);
> Agreed that fix is correct.
> However, we definitely also need to add some documentation on why it is there.
> 
> It's not actually an alignment force on sampled_vals, but rather on the timestamp.
> We can't just mark the timestamp as then it will have two aligned markings on x86_32.
> 
> David, given we both missed this when 'tidying' this up wrongly what do you think
> would make this clearest?

I think it would make sense to have an IIO_DECLARE_REPEAT_ELEMENT()
similar to IIO_DECLARE_BUFFER_WITH_TS().

#define IIO_DECLARE_REPEAT_ELEMENT(type, name, count) \
	type name[count] __aligned(sizeof(type) * count)

And it would be used like:

struct {
	IIO_DECLARE_REPEAT_ELEMENT(s32, sampled_vals, 4);
	aligned_s64 timestamp;
} scan;

> 
> 
> Thanks for reporting this with such a thorough and detailed investigation!
> Makes our lives a lot easier.

Should I spin up a fix?

