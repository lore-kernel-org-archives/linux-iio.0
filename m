Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCB30BB94
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388337; cv=none; b=NGrtwf1AJ1u/87n3tNVqBrIw2pV5IPz9/ITkFXRHig5uTr3fVkRvc68HUJ6vgOWKUifMK5L9qKkDlzn6zBUf8OsJQvxKUf2dpSrAokEsyncAFqZFubfqaO7U3NxQ/xSigC9O7ZDuQ8qhLbqDdK3apmCuZKGqZYufPHx2YCU3EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388337; c=relaxed/simple;
	bh=GWqzWiq+j0RxHQzZhZDV6By8omBIwJBlTOY3h8xOhoo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Sl4Lzy4WilgKpRrAQJcJkHYS6iAivjAsDjxyyx8bsYrO+3Dowce1Cer+E9VWQ04YWRj8UN9fR8k6aI8QCkoMJyycGoPQDfaZs8TmORakzkdfvIE0U2lSnEFHNRvQIvJD5rsE8OSEzvRut6YW+Omjki5MUrys+p+0BG1w9OkLgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIROQD/P; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIROQD/P"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bd742e0c20so2630029e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 18:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783388335; x=1783993135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LriMcSNJ5pcK00Rw56VbtN5AdDBaoG9VSgFiEqdgUk=;
        b=bIROQD/PCTvnWTdqwzoIn5+ewsoEy3EpVKsBeEjXldRRYe8O5rkNOqiy45UwwX5Wg/
         VvAHknS7mbViq+QVj1KQ/eYdJ4ba1IKXiO2W6ZIv0hzt4aLG/38rstzA01hnY6JaeYXZ
         +/Ab0qKHP1NY+O33kDiXv4066GeNTxs4UJoPBjWSvfwBeimacYgP7d0ThtHMGZd5tUEq
         LleOMHeLBRCuyYex0a133Wo/WoWJCu4e09DoEvU/tX+rua6acJkHlz7D2QEsxjgaWHbf
         nmyxdPOCHLFgB++fn4RRz4Gv5M0bXojWXESRu1ssEvdBlI/VCbfrroMCH/9KEWX3A3gz
         FWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783388335; x=1783993135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LriMcSNJ5pcK00Rw56VbtN5AdDBaoG9VSgFiEqdgUk=;
        b=Y0GktFLZHbD1diKIo9usc/6k1fKvAnrawuw9l+syCExPVl5/ejoGhDwSco432U5SIS
         kEWwC2NTHSdVJcV1yPyKdcm7NOa158qDr2/vpo/2LGFHGANEqUaJ/WwpaTarU+q9xwnL
         KU7si+ldyS/Xisu7qGCUY+lRXZ+mas/n4XEDK+YOgi4ueBWFTpJuMh30TLRPWLLop9/g
         MQzBw4Z4SDjPUxh/vKonMFfeHZ0xgQaZ1X4HGb/jleWvpRDakulC+jYrZl3L1VpsCq2x
         yh11EyHnih4lAF5bBZF7IsfwMFkwsZJDSBSNGBDAoYrO7/gh8xk3n+QR0wnOoJfynlHQ
         E/Rg==
X-Forwarded-Encrypted: i=1; AHgh+RqeRDP4y2Czm7zE3yjGFLCVi1RNJlcz7VtUGUFYnszbKfwFrnGW6zaOlp480oDi/KgqoEAHPV7nWY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkD2IALg+Vid0oamGGN4DOS4ZDaJyWKNGqulH6UE3mRuuQFW8Y
	TQ1Kylet7zi5r5k+vM2focPV6VgU6AGy3F9/LjBJ0C8YQzmjHC8KaUis
X-Gm-Gg: AfdE7cnfbwcsmULAXLbDpEI0doOoLHE+KQRsNS7rnloyRJ8Pq822PjD7sVaG0Hjxt1j
	9WwRLYWMS6wgifO4tLadS6vuL0dfRXt+8rX6OlzEhl7Xl+vdPfHMuqX1WhCdqNtaST9SK7yihXr
	UsaUROYwfmxqkFlJMsfdF1SLy6VwANjCvjgUN7yByogCFcHt/TKKH76eJuiY5dTa5hu3BQ2pBA6
	oHMq7Rqdd5jwaJoL+698Hal2WgN/j0LF0bX2GBamE4v+YqxLav/yQ0tNbJ+svAwc9sm0D6nMqVU
	waryRHEvFPiRXlRn+nj4Hc9PSXu3KuAzKGJqCQj2BT6Q8HjiIy994hv/YBieFNndoCAm6yv3Nv7
	DLK3qhiaQjrwLe+sm4P/a23uWtkMIzxIoVdUDbCUoMhUlJEGdFIIU5cKvpEwyxPC/xJQbJyMfvA
	meZ94=
X-Received: by 2002:a05:6122:3d4b:b0:5bb:d233:70bd with SMTP id 71dfb90a1353d-5be8974163emr1912443e0c.2.1783388334524;
        Mon, 06 Jul 2026 18:38:54 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be02934c13sm5894170e0c.3.2026.07.06.18.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 18:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 20:38:45 -0500
Message-Id: <DJRYEEGVFY2A.2115GKK5BG36M@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] iio: adc: ti-ads1262: Add conversion delay
 support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-5-4b1b231325ba@gmail.com>
 <20260630015027.3afdfc3a@jic23-huawei>
 <DJMK3NCDCHL8.1EHG93D5O7ROZ@gmail.com>
 <d8fbab77-6cb4-435d-aac9-0d72cd4a59bc@baylibre.com>
 <20260701012026.29f18bf4@jic23-huawei>
 <8dd4bb6b-a83d-4584-8893-b56b8aaed973@baylibre.com>
 <20260706182317.64cb0a4c@jic23-huawei>
In-Reply-To: <20260706182317.64cb0a4c@jic23-huawei>

On Mon Jul 6, 2026 at 12:23 PM -05, Jonathan Cameron wrote:
> On Mon, 6 Jul 2026 11:19:40 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 6/30/26 7:20 PM, Jonathan Cameron wrote:
>> > On Tue, 30 Jun 2026 13:44:49 -0500
>> > David Lechner <dlechner@baylibre.com> wrote:
>> >  =20
>> >> On 6/30/26 12:23 PM, Kurt Borja wrote: =20
>> >>> On Mon Jun 29, 2026 at 7:50 PM -05, Jonathan Cameron wrote:   =20
>> >>>> On Sun, 28 Jun 2026 00:36:06 -0500
>> >>>> Kurt Borja <kuurtb@gmail.com> wrote:
>> >>>>   =20
>> >>>>> Expose the programmable conversion start delay as a per-channel
>> >>>>> IIO_CHAN_INFO_CONVDELAY attribute.   =20
>> >>>> Coversion delay was always a somewhere weird bit of ABI.
>> >>>> What are the delays relative to in this case?
>> >>>> Is this a device that does simultaneous sampling?  Pictures
>> >>>> suggest otherwise, and convdelay is currently only defined
>> >>>> in that case.  We might be able to extend it but it needs
>> >>>> some thought.   =20
>> >>>
>> >>> The chip has a configurable internal conversion delay to allow for
>> >>> external settling effects. See datasheet section 9.4.3 if you'd like=
 a
>> >>> bit more details.   =20
>> >>
>> >> Since this depends on external components, it sounds like it belongs
>> >> in the devicetree. I have the same feature in the chip I am working
>> >> on and was just looking at this and plan to add it to the ti,ads112c1=
4
>> >> devicetree patch.
>> >>
>> >> This delay only applies to a "new conversion", i.e. when certain conf=
ig
>> >> registers change, and not every conversion, so isn't like the convdel=
ay
>> >> attribute. =20
>> >=20
>> > See settling-time-us in adc.yaml.  I'd forgotten we had that ;) =20
>>=20
>> I got some more feedback on this and this may indeed be something we
>> want to tune at runtime after all.
>>=20
>> I'm not really sure where it fits in though. On AD112C14 that I am worki=
ng
>> on, the DELAY register value adds a delay (for settling time) in additio=
n
>> to some other intrinsic delays. I'm pretty sure ADS1262 is similar.

It is! there is a fixed 52 usecs delay after starting conversions.

>>=20
>> So one question is do we want a usespace control to be the total delay
>> or just the additional delay?
>>=20
>
> Total I think.
>
>> And when the delay takes effect depends on other things. Normally the
>> delay only happens before the first sample after any other parameters
>> change. If we read the same channel again with the same config, then
>> there won't be any added delay. But if input chopping is enabled, then
>> this delay happens on every conversion.
>
> Hmm. That is awkward.  I guess the best we could do is either to document
> it as 'may be skipped if channel setup is unchanged either via explicit
> channel or parameter change, or via chopping'.  I kind of think of choppi=
ng
> as advanced channel sequencing - inX-inY being switched to inY-inX with a=
 scale
> *=3D -1.

Thinking about it this way, shouldn't there be userspace control for the
chopping stuff too? Something like in_voltageY_chop_type, similar to the
filter type.

>
>>=20
>> I'm a bit on the fence of if we should extend the definition of convdela=
y
>> for this or if we should propose a new settling time attribute. I'll hav=
e
>> to think about it some more.
> Smells different enough that we shouldn't smash the two together.
>>=20
>> Maybe something like in_voltageY_calibsettlingtime?
>
> calib might be reasonable if it was a tweak to a fixed settling time
> and like other calib stuff would not necessarily have any scaling.
>
> If it's the whole thing and in seconds then in_voltageY_settlingtime=20
> should be enough I think.

+1 for this. in_voltageY_settlingdelay might work too, as both our
datasheets call it "delay".

>
> Jonathan
>
>>=20
>> >  =20
>> >> =20
>> >>>
>> >>> But you're right, I should at least also edit the ABI description of
>> >>> this attribute. We can postpone this discussion for a future series.
>> >>>    =20
>> >>>>
>> >>>> Jonathan   =20
>> >>>    =20
>> >> =20
>> >  =20
>>=20

--=20
Thanks,
 ~ Kurt
