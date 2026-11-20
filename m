Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172958;
	b=k1USfmHBCArxBlqeFCjvfrrrA7MgNfmJKj8a4KlCnfR7wj9a7E9h1GS89U+HzQLPDPP1
	 epGIj9wDvqItrdU8U1aJCqArwlpAWJrD5G0JsNjBK8ZRgWYVzjx/Ju3kd6LCeA5bITzmr
	 aEmCy7papHu9aJF1z95uCKHkcmPY1/FqX459LW2jGOmDtB4qsNatwVFN7dxr9+LQH9/IM
	 4y9BdceZypQHh99jpN1UIPAJXNuFUreVDN3+KvJt4VqO4DKuzd8/J/cE+8BFvlG07FBey
	 odGS2bIkZyknUPogr48YyThFwQygWp+4N+s51ScniIFOCxTt9Ar6Rc+QDHS7iqarRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172958;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=tMp47NzqReywlgYM5u2EyNEpsZnozcgtiE9STnzc4H4=;
	b=EbNYHFpAjKAQWECGGi5eA156t/hW8vujJy9d6XeGEBuaBvGF8MZIRYnr3NUbe6Dw7m0Y
	 mv7gYKhrIOnVUSbTjxNimmUAnvmQUivXf8+zWZnyoRDSLCYS6iFf2HyfBgRxK7ihdYyZl
	 LWbULWMIkQF4YOzNO3lsUKP3PzsqK5NLU9NCM8lITDFB6QTYK0MrlsIjkOErSxRDkzPl6
	 P388RFMZFxp1KL4tAS4X6i7YoRBEjg4Jd9BnJ5Dnt7heyDxdITKYfYNerJ+saffu9dnNh
	 7w29KnvDz3ut1j0qlsMLZIT9de7YhhKjVwfCpicubJbTXf3NM+OMUbrjCwDyY0dN+cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD460A2602
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 11:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBD460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-547ae874949so1354972b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 03:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172957; x=1795777757;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tMp47NzqReywlgYM5u2EyNEpsZnozcgtiE9STnzc4H4=;
        b=EjmeY0Dhmi9A+MKDq2BS07RYtIzh0D0kKLpPIO6pUClYxZNojAXLeW/Zneykp7y4uk
         HeF7Hh5GLZobISxH3n2bWTVl6z9wX/K7PvhAyAPLGD9ABIvePXZevIc4QE+1qi+GMkrt
         n5QbsN6pXUxHgoOZmsW4b1QJXxyP/8cYac3YyM2UXPbOnkn7I+bWkurpAcw84l+BVzvE
         70hgUp4smkD7AsknHTtR/mNhCQOlta8Y/q9rvcCEGhU3NAoDhVWtovwCsjh5ykJgcjXK
         zqNhZQZ0Y0xLzNtuuyMpUy4Cm239P2NmQEUR49yattWYyGTEuxWkm+XwEVYGrIpV07H+
         v1rg==
X-Forwarded-Encrypted: i=1; AL+hErF64MhDp3HrvFX+nMHZculc+k5bOa1sMCgkiecF/3uaEPAplFreEKlqTF9P0QVMUOn5YV5a5TotBX8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vFRou1n7mWBqJQFYVf2jxQ6owpw+nK1HPBHncRNEHLBjIeqhd
	vLcvjMw6D4qSCrBW/6UKSKmoumO1ccBGTGWMDsUQ7KxWUuFdQwTbfdRTiZNGDNfd8Zsckba+6by
	vD658Ru6DdCUOjMsbYDra1sY3xzByqF9l+MVryzaYO9X9QhuLMXrnhzqBw90=
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1393:b0:573:399d:d487 with SMTP id
 5614622812f47-57a0d0e2d03mr3179763b6e.65.1795172957190; Fri, 20 Nov 2026
 03:09:17 -0800 (PST)
Date: Fri, 20 Nov 2026 03:09:17 -0800
In-Reply-To: <4f254948-29d5-4011-8865-c60a699d9bac@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b002a5d.6ea51c61.12eec.0010.GAE@google.com>
Subject: Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
From: syzbot <syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com>
To: crofts@kernel.org
Cc: bentiss@kernel.org, crofts@kernel.org, jic23@kernel.org, jikos@kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, 
	viennaoffh@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

>
>
> On 20/11/2026 11:50, Joshua Crofts wrote:
>> On 20/11/2026 08:56, Zheng Shuhao wrote:
>>> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
>>> sensor hub removal.
>>> 
>>> sensor_hub_remove() currently holds sensor_data->lock while calling
>>> device_for_each_child(). The child iteration enters the device core and may
>>> acquire the klist lock. Since sensor_data->lock is also acquired with
>>> interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
>>> lock-order inversion.
>>> 
>>> The callback only needs sensor_data->lock while checking pending.status and
>>> completing pending.ready. Pass sensor_data to the callback and take the lock
>>> only around that short critical section instead of holding it across
>>> device_for_each_child().
>>> 
>>> This preserves synchronization of pending.status while avoiding the lock-order
>>> dependency between sensor_data->lock and the device core's klist lock.
>>> 
>>> The syzbot report is available at:
>>> https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>>> 
>>> Testing:
>>> - Reproduced the target lockdep warning with the unmodified kernel in 3/3
>>>   two-CPU QEMU runs.
>>> - The warning was absent with this patch in 3/3 equivalent runs.
>>> - Ran the HID selftests against both baseline and patched kernels:
>>>   hid_bpf: 45 passed, 1 skipped, 0 failed
>>>   hidraw: 27 passed, 0 failed
>>>   hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
>>>   hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
>>> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=2 in both
>>>   kernels because no executable test cases were collected in this minimal
>>>   QEMU environment.
>>> - No KASAN report, use-after-free, Oops, BUG, panic, or general protection
>>>   fault was observed.
>>> - checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.
>>> 
>>> Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>>> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
>>> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
>> You cannot add a Tested-by tag with your name.  This is reserved for when
>> someone independent of you tests your patch. Looking at the syzbot report
>> there is a reproducer, so syzbot should test it. You can make syzbot test
>> a patch by sending the following (note, this will trigger a test):
>
> Ah, did some digging and the syzbot email is incorrect, it should be:
>
> syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
>
> Cc'd the right syzbot and triggering the test.
>
> #syz test

Patch testing via #syz test is temporarily disabled.
See https://github.com/google/syzkaller/issues/8122 for details.

>
> -- 
> Kind regards,
> Joshua Crofts
>
