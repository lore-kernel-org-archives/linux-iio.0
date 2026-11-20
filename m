Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171854;
	b=mAzvSFXX7uWrtFjS7OWxPdHHWg7LV9UeDDMyy8fE0m0RWJCOa4d6trQd94vGLaPlbTRu
	 oz98aInT/jaeBtJvB7C3k72sM9zzJz9XLvJoKqpSOnJyvcf02NTBHXs+XxsJtv+BdmtTu
	 2DEdEJd6VEf9KTPyME+ujS5TGjLgajFAmdBsYScdTU4zTFyKDp1JCMOrl0SdZTmfwQQaQ
	 yPnhmy4K/RW6WYGGdNU2hjGe0mlco08YWVtfYBdZKgZu2fb5TySG5Q7VoE+D4d2MW39Di
	 rhm6blRBejMEeKdRcKDDdEio/NBQmf+k/ZpAO8Gbz0pneoVMFu9Q55yg1GA014h645g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171854;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=RuCBGxW4k+nLAhcDYdOOEYmXXtboFDr5QBxJOONXv6U=;
	b=Y9NYpqPLzguE0XcbbikYxcrg7yffMycMsHKv/p10LxyO4ycHbnaTqhFwI3s7ZJ2JMCoN
	 u5OAu+bODNly6MHm/OqA0MNzPmtXMKaPoaBJuNDdF7ge3m8VvoMMjJZpyn2krbaAlTrPm
	 hRJGFSpJjYhkVwN2qBJTcf9DgNnvC9VogKPP81lRS3gdw6QzJ+PRrrBWL765d6f/LeatQ
	 ORafRwryJAtGhLrH4xjR5f3fQM5wkRWAxXFV/psgoOZCrAfZkg5Q+P/Iyxcg3WVEHOCW9
	 Dag/bCiAmgdMQuX/qzm8q0SwasRo0fncEPLXtuJ/twZDQKHGiwr7pfyyE6Yzy2oqwNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6360A260B
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F6360A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4dab94dc3e7so1988497b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171852; x=1795776652;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RuCBGxW4k+nLAhcDYdOOEYmXXtboFDr5QBxJOONXv6U=;
        b=jPd2M2hM1yt806BzNDF1vrzXMkZvQOVDY/eKtmJnzsmjHkzh8oq5BF53nedTayd0nw
         VcaTzgcCZtIHlRybrnf4T/kFcKY3VdGTdG8Zl1leHODSVuZXVFR9CGj9s2CXaLtoBgZN
         EyJwf4BrCPXujczlDVEwyKXKiC3Wxp+wWNV6h5YZIrQnRalpwQJWbOgf83JrU0k/9P+M
         2ozvQ3+OQfsUQZ9pUEka7cvxfuCME6deTvN1nv8Sk1vgkD0W4NJBLnV3bBovPyBB9sjB
         dXxKAcKlFmFtVHgGBvq2nlBzctSeIy9wOrOy28OpnpRoBYgAjPICyRtrXu5hY5FE+1pF
         Iz+A==
X-Forwarded-Encrypted: i=1; AL+hErFcMpcI3+v2Kf2FnrOVS9ZS3JGqiKJm29RH5xWuucbCTyhxKuC23t211R3ob+jOOD76k7zPyDqbzp8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sHGGD21W7EzG/OBwJBEKNNqC8rTb6qCWdPp7I7+Eeway561ZX
	uoXz6GJmuQ7SxiRZJBYG2wOABS/xKUSsVFfQuZ5tAM6n8hnLpl+ltAZ7yxWQnOsWS4RwXl61lCr
	NZwGKXddCiIq2n7L7GZe7TVJaCBAvGs9FB/5plYDGWrMX+j4aCCFSAMn8JcE=
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1783:b0:571:76cb:b4c5 with SMTP id
 5614622812f47-57a06b25c93mr3051987b6e.2.1795171852750; Fri, 20 Nov 2026
 02:50:52 -0800 (PST)
Date: Fri, 20 Nov 2026 02:50:52 -0800
In-Reply-To: <0428126d-684f-4b4c-a805-7dc3e2d56897@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b00260c.c48d0c14.ca62.000b.GAE@google.com>
Subject: Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: crofts@kernel.org
Cc: bentiss@kernel.org, crofts@kernel.org, jic23@kernel.org, jikos@kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, 
	viennaoffh@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On 20/11/2026 08:56, Zheng Shuhao wrote:
>> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
>> sensor hub removal.
>> 
>> sensor_hub_remove() currently holds sensor_data->lock while calling
>> device_for_each_child(). The child iteration enters the device core and may
>> acquire the klist lock. Since sensor_data->lock is also acquired with
>> interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
>> lock-order inversion.
>> 
>> The callback only needs sensor_data->lock while checking pending.status and
>> completing pending.ready. Pass sensor_data to the callback and take the lock
>> only around that short critical section instead of holding it across
>> device_for_each_child().
>> 
>> This preserves synchronization of pending.status while avoiding the lock-order
>> dependency between sensor_data->lock and the device core's klist lock.
>> 
>> The syzbot report is available at:
>> https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>> 
>> Testing:
>> - Reproduced the target lockdep warning with the unmodified kernel in 3/3
>>   two-CPU QEMU runs.
>> - The warning was absent with this patch in 3/3 equivalent runs.
>> - Ran the HID selftests against both baseline and patched kernels:
>>   hid_bpf: 45 passed, 1 skipped, 0 failed
>>   hidraw: 27 passed, 0 failed
>>   hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
>>   hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
>> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=2 in both
>>   kernels because no executable test cases were collected in this minimal
>>   QEMU environment.
>> - No KASAN report, use-after-free, Oops, BUG, panic, or general protection
>>   fault was observed.
>> - checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.
>> 
>> Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
>> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
> You cannot add a Tested-by tag with your name.  This is reserved for when
> someone independent of you tests your patch. Looking at the syzbot report
> there is a reproducer, so syzbot should test it. You can make syzbot test
> a patch by sending the following (note, this will trigger a test):
>
> #syz test

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

>
> -- 
> Kind regards,
> Joshua Crofts
>
