Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423644;
	b=r/VRpbG28VuTxt0q2jIqSYKFgurx93k7p2BjrHUPxEu0vFST1/XybubMMTal6Jy4gFbW
	 NECOlkIlZQ9Z61IKVRqNhEaKY3uLJWxuLR29b0DFdbfWNr2MOwhz5exZZAR9sUjURvjNz
	 i4H921Wv09v5I+h5FB+nMyhlNi+iVIpOwO87UMpuu9MirzJFByUSgRLPJdVeTn+FGdhkh
	 Y96rY7fzL7L1TMYaOmIbdFom2EIjA58vYk2MhJajgvFn9DQQQFZj253jVFxFnRfjf5KDi
	 aRTxcUaTcFl1X82pz2XVOla2UePMDaeERB2OLaWULMowZHWaprLCNNusE8RBZ5K93pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=a9avre7WPVBTm+1ssGfTak2MnTio6f4/ruqgmNL/TRE=;
	b=gt59YwdG7tf34iD1Ty0HcNI5zMj0PjZDxHdbpQrRzqKju+Jb1U9KzgF31+BSgPN2oB9I
	 UPtyHpq/LmsA5k5u+JVs4uAWWDzM5LdIpAUZHh6Gws9+GuP5PvA0zJkM/Mm1mkUZEylFt
	 eMyvK+Vs5I8XaJu6G9cqVxtrYK3NnV6vjymMIt1XJcF1SMwlX5mEG8VBGinXjPrV1W5PD
	 zoRMLoyFk1UtUh6OcH6TwVfJoe/CmZAhs6RRqAfYDi3rN/FqWdovsCO/AcHypkU2oWM77
	 K+7tsn4PSWd+EJAvonQ28x+v1l07smYjnSA5gbSNTuerRMK2UFLE4I3ymA6XfaSZK2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEWpBz0U;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE5606A327
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12CE5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEWpBz0U
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1176311a12.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795423643; x=1796028443; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a9avre7WPVBTm+1ssGfTak2MnTio6f4/ruqgmNL/TRE=;
        b=QEWpBz0UF+1mc1fKVDkphV8Vq4Od5PrcQOIScdeTZwTHzNVAeyUZ7atmbcZwDRSx5C
         N9BE3MswpXI2ysrY0V0pC+iuFUgXVGkjHCcJZDhk/J3TfM5WJPkPVU1sdHjuMkm93WoD
         4wnmZiMs/Tj0led+OWYVnQfjkFsVsDw0SSpyr9gK7Kxr1fgpqa4VD7KGk1iblYk27dfV
         bx69GBVCacNwq6JbAY8ZKc1kQytU15PmLYTEWqSF8MJrqyy8pJwad8dcqj22RWS76bTg
         W7ddBTGFIvgJcat39+CKHAyp+puat+bN1IEcW5U9ibMNVNbanKAKvpOLobUxkD9/N9YE
         uAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795423643; x=1796028443;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a9avre7WPVBTm+1ssGfTak2MnTio6f4/ruqgmNL/TRE=;
        b=EK2+pkMj1IR8bpAH6ETwf0XJ8crhDanRvKHxc32lh1MSNL425qjtOLyxcHwxAD4dHv
         1X8iBc8IxxQpqtoqV8THxhd8MNWq3q3R3v0lp39LvFHSRvc3wSeDekE9BCx4VnM/5Af7
         iV8TPeR5tq5X+yCykEMTBbEKbtfTCfE07uDKk3JrjODaR5GKYV/5AUN9O+8WvrYujqvI
         gy5IIcQF65wjVpIRfjPGXoDMcl/SyYIwAQtbXr25zUOdnDfLPfZ2FiidlnQP/kkN1+pm
         UNDe+/7o7HwsmwpBXWpAnz7LvIU1IFAfJ0PtXtUzlaQasKBa0tT682RQNxfJS9gX2NCp
         twWg==
X-Forwarded-Encrypted: i=1; AL+hErFzGjwC42BgLHtQH+3hd//3nt3k5Zq3GVzrxnUd/qKEPwhIzRLEwbGdx+pOorAiPc+n9EPBIukxb4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P8j/nAqcJ5ota8c65ukqiCDkaLcRFNzB1EycVDNHsQf3tySx2
	NV+NgidORW/qwaBbtNcaDgfCXaaBYOtBKYH6b7fU8Kudw7QsNdnZNqyM
X-Gm-Gg: AZFdTZfYGlEMd7jiFYfpozo0vpTIZD91d6UzDSq68Wb/IaGuGsYupDN0rr5LFk1n3Vw
	P779qQWqYG1Kzn/q4QTjI8D0WLf+CSNtGoUvvQWky+rZcD1M56uoBLBYXw4jlUPIIWabMihQFvF
	0TWxwBSKQcBkoEewdajvD0mWQZ5V8msutJ56IGQQz3BpLhKaMtQfByzOaK5bexj3y7erGGniNJh
	4bgA0n5LRMBq70TJW7DUOVaBNo8N93xNn4MMdfyPKEWcJAjYdgZ50zGdpIjvuo/Y2V7j+tYeouv
	/aj94gp/XrhZxcPHSGmQm6msfMzs9KqlhUjg7nb6r6rkVC1GYwf/Oe8uUNQ2BnPsQ/axhITQNya
	CZ9s/X3Q9sRq+3Q7Twfi1ZoRZJwPZjzZDXk4QavxcMKkgH/eZoCifaKHjGmm0MQvVnAkJzbFqtc
	wuteg4J05lPdI5QRSNUkeXrKiaAgGc5LmJ3iy4IyXG0WDIYjtXpo+a1M0wAUoHjn1HNlz0Evi6s
	B4gSp/neET6eRCivS3/H2immk9ZIeFctDIriQ/gIG5kicIZ7Z422G/aTvjvkp5glcMQ+8smAN8C
	mTb6xRc16655Vas+Q4Qqz+t0rl5nbdo/OCEcr484j7v1vlof
X-Received: by 2002:a17:90b:1cc4:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3b41caea9e3mr8391385a91.39.1795423643465;
        Mon, 23 Nov 2026 00:47:23 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm18558082a91.3.2026.11.23.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:47:23 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: kapoorarnav43@gmail.com, jikos@kernel.org, bentiss@kernel.org,
 srinivas.pandruvada@linux.intel.com, jic23@kernel.org, lee@kernel.org,
 heiko@sntech.de, lixu.zhang@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
Date: Mon, 23 Nov 2026 16:47:15 +0800
Message-ID: <179542363584.4684.890797902249469950@gmail.com>
In-Reply-To:
 <CAJi8Lv-orD3VA1NJ71L1Qcw6=AWuBZesVFOHe5Y+bwzWxT8KRg@mail.gmail.com>
References: <20261120210317.184756-1-kapoorarnav43@gmail.com>
 <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
 <CAJi8Lv-orD3VA1NJ71L1Qcw6=AWuBZesVFOHe5Y+bwzWxT8KRg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ayaan,

OK, I think it would be better if you sent v3.

Thanks,
Zheng

> Hi Zheng,
>
> I'm fine with merging the fixes into a single version. I've just now
> read the other mail thread.
> If you can, please send the v3; else let me know and i'll do it.
>
> Thanks,
> Ayaan
>
>
>
> On Sat, Nov 21, 2026 at 7:08 PM Zheng Shuhao <viennaoffh@gmail.com> wrote:
> >
> > Hi Ayaan,
> >
> > Hmm, I overlooked the latest discussion, which caused some overlap
> > between our patches. Sorry for the confusion.
> >
> > We can merge the fixes into a single version or find another
> > compromise. Either way works for me.
> >
> > Thanks,
> > Zheng
