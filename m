Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7892E228D
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472287; cv=none; b=t8K9ql78UNTen/yyh6hm8mv9QbE5Rh/JesjbqA1NXAahH/70aY6ZrNtKlhzs/NqJdwou1pVbglUXfOB+a52OgRusqBOFGBrnZiY2oU7iW6VexcgJhhmBaZg+650TA3H5rQstCqzcz6m9hhulXy9hodMQRba4HS9BpQVPyRtfY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472287; c=relaxed/simple;
	bh=XxBdA4BXaeozKYYBYuSw/1FQ6CuFD0RJKEjncMA69S0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F9+LEW+4f49DM0Fu7bo7P5fQI9VDTGjb/E70FoU6vlVxbdpOLeIQLLIAOFR9W9avYbYf81Xr9Gk1BGJog+kdjWAC5YEGwjfC8DgCAe6+WbJ2BtpCZVlQXns55d9VVfgWtDoqYPCxFjzOSsOpU23WlTN5mX66uil8fE++c+rF+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nis3flTT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nis3flTT"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915aa0a9293so362562385a.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781472285; x=1782077085; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT+kdFMa8x6bQgtH/7AkogoY3MWUlKu35QK/VLka/7k=;
        b=Nis3flTTP0gp0jwDUxjlUneStLWFXJJXe8TrEpkjl5dS16glCnpeIJPVkx2Eq3HOr3
         WoQDQ6/s/u7sX2PEaXuDitOuGF9uKubImIJJFVl0Gc38xBK5h6LGIquuaTto6rWPAtgA
         iicDiHVh2c2LV8MT0dqAxDrT03a98U8UQmSvaxHGCSfozEEtH/mBei72to5tIPSp0KxV
         0fe0QoSYYFahf94VDb2u2i+tNOO49TnwQ4AmmbnV/Gc3zkIaVX3vw6ijlGQF8Bb5sPEh
         9JAkUj0h+uOA4r9i7+Lm/VEJbX+95YTHDYqdVpwUxOSLPB+JDGNDfMEb9h4iVRiu1Sk1
         Q9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472285; x=1782077085;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hT+kdFMa8x6bQgtH/7AkogoY3MWUlKu35QK/VLka/7k=;
        b=OVs9iwYAOleeAMxT/4cLIQ6yKZkwpYYelmkzvWR44BGY+stZCVEgJ1302hl/+SoDDj
         zAUURsgOTnBi+HcQG7PH9UZDLsLKpSddwoBCK+CTEpA0yeDOVDMs1EtLFaOLK6D5kPQz
         iID6vGuRBHfP24qpz5C/u7fRPt09yOuyD83xXfS6SVTV1+sGq5MImFg44AkYJrMVWAfN
         FEBGpZVAjwxQ0cIpWc2wlTMDve1jUAO8iziGfxjVEjoz3PorDjf8PpQsbsI4wJTYSsvN
         0jPkyQPf7hHhBE3KCbvztNVH3cdP9nZSzwLuuco3kp6oZSPh3SvDYBDK+wuihdJDG91o
         Ipdw==
X-Forwarded-Encrypted: i=1; AFNElJ+IlYk0Sx4L9rApJd4L7cYYvMM+XOwraroMLro2fryfmJ5GT7mKQ00pBCpQsl8cEUEmYtBw3W+2GtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9RN+tIbsYV2e0Kd+OrYFS62dYhX+hBeqXTUn0R1whvK5R40y3
	6nminLp+yT+oLJC1V69J5iTIlIdstG7s+KhbJxBjlYlbnyIkBuLq8eqK
X-Gm-Gg: Acq92OF8scDL8WZU3Ubukig530hhWHEwgIYfHYS4KQM3sJEVxgzBfop0KNs9RbLcUp0
	w+sVCWg/Hed1CFP93YKF9eAVzF7KxaIT/4qFYgTqrcDjpU7xqZIbTp+FE0xXvv/bZZzXLTBG+NX
	m0mGU9g3/LczFJaBK71t6H5efATAJhFUHEt1D0pJHZdcIQFDzs/YMbfoOxlIqG6Vo3Z0Xg57oRB
	gAYKsns+kowSz0YPEJi8Zg/jbp/OmuMkiZbmIb33U8gwGcCs81WQ+7JAMNPRvFtY7zO458Pz7LJ
	r7VRm4roY/5Dzs8fgDsTyDiL6Hj9ZYVVfxkqCB9lPdirnZd7p/yxFkvf99EHeExG57nYGgrhbOL
	KoDTwfjg4mOE3+sNR+7jfVkS0iu/TsEia34t3f8mBkhvoZlje1NVtnIuoNVG+ilyeVcuERUCEcB
	VGKOGSx+ArPGq+vKYCreZgwaqyAmt/CWqqgxZaK+fPLjNmB4HS8jbhJGKk5nYc/ZZn2A==
X-Received: by 2002:a05:620a:370b:b0:915:98b3:a356 with SMTP id af79cd13be357-9161bf9225dmr1512255085a.11.1781472284962;
        Sun, 14 Jun 2026 14:24:44 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb90:eae2:4af:a16a:929f:e43c:51a8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a03d6fcsm836971385a.35.2026.06.14.14.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 14:24:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <20260614160213.085e1efc@linuxescape>
Date: Sun, 14 Jun 2026 17:24:12 -0400
Cc: jikos@kernel.org,
 jic23@kernel.org,
 srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org,
 linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
 <20260614160213.085e1efc@linuxescape>
To: Maxwell Doose <m32285159@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jun 14, 2026, at 17:02, Maxwell Doose <m32285159@gmail.com> wrote:
>=20
> Hi Shuangpeng,
>=20
> On Sun, 14 Jun 2026 15:19:21 -0400
> Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:
>=20
>> I hit the following report while testing current upstream kernel:
>>=20
>> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
>> hid-sensor-custom
>>=20
>> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>>=20
>=20
> Is this correct? It seems to point to changes in HPFS.
>=20

That commit was the linux.git HEAD where I reproduced the crash. I did =
not mean=20
to imply that the HPFS merge introduced the issue.

>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
>>=20
>> I'm happy to test debug patches or provide additional information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>=20
>=20
> This bug report also seems to have nothing to do with IIO after
> investigating the call trace, seems more like for the HID/input folks
> than iio. HID folks, seems like it was caused here:
>=20
> [   73.163547][ T8356]  hid_sensor_custom_poll =
(include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
>=20
> before _raw_spin_lock_irqsave() gets called and KASAN triggers the =
slab-use-after-free.
>=20

Thanks for checking.

I agree that this does not look like an IIO-specific issue from the =
trace. The crash
is reported from hid_sensor_custom_poll() in =
drivers/hid/hid-sensor-custom.c.

> --=20
> best regards,
> max

