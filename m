Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60B2C21C5
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059157; cv=pass; b=VGm4GB8MldaS/DxWOOEs5d5uYT6q5ZNN5QWRm1DmF/cnYYiJU4jlsMprdlFT2uNOGHnA8/ZNJ3iNRfpH7gVSoVnrlv0VPzDXEqYc9bqEeqzVg+PjwHeqZbLPa3LyRg59FsJpfFlW7f1TAykGZWhO9Wrm9cMSW96fRPl3yIdP/mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059157; c=relaxed/simple;
	bh=YTKSyjfM1aCnF/fsctlBeRA3k3Js+B+P61PpTYUydDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiS9LXBhfBX+QTP1BGgc4ph/12yWwzvX+u5fcMuE8yfS8QEhv8/qd1rteN3Di8THHzfJ19QVfoI/oDd2hT6BqlkMkZUgbaLqd1K4srmzK+O9Qo8VXbQ24FDhY8IyTpqTYVU4zgRhSQQ09zNwmksUW7Wpwny/DEXp6BzHCAda4H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP5RzSDt; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP5RzSDt"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f0ad52830cso17991041eec.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780059152; cv=none;
        d=google.com; s=arc-20240605;
        b=XFUFVBaHrgo41CpE611qK9D2QolDqD1d3nuB9SS2q59gcNGuBoUjG4TtgZmp1AKoiM
         5IoN7N03FKAdzODqG4K9psqd1PPd3LuJbQYXhLuBqToT2LOfzPXp2Q1X2MzI9/tz7c9G
         taBZ775vt+QmPFG83MmafXP8jNL9ZMiJ2iAYcqs792TqUGY/ggKDZxRLjhkfT1s4GcXt
         C72gbQ/MTajVF/tIuPk1HcL7PhaTagHOm3iEcsZSb12+kiGYaOMSw/ZNdQRISfcPUHh8
         sHT9FP57oG/xdXlZtEsn1WPoO9QcwxdV+RFJp7Dnia8zB3jH57v+Uy5IyBJa5MAjQc+H
         937A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6N0Dxr90tSGN8D06PZxqcdaObrRzD2iypgyadxATbBQ=;
        fh=UBjF/oaYi4vC6OARkco+8hEEXBrCV+v5SUUTBWTLU8U=;
        b=MfkZBbzpMlM6ykzjJQWeeClTLjWnp4aMTn/kTNzHiUaQx2MuoMOM5IrYMngVLI0g8N
         nxMOHWPrMf8Wtq/zJpsDr39qzkUEgevtLEbyCaBmMnYgNWRKsC9UIN39bcU42TkzYokE
         n9hnCdVUcPh3cqwWkQ+oYoyXmr1KoyTAcUmw7qntIxL7c2hdywjWG5gbA8z6yhZxVtIH
         4Bu2pfufPBii3/YYEhzzq+eOEQENZInRlcJd8XXcAuECOtRhMyUnGjzDe7uqH8RfKRkO
         amQSr6ad+WlF1H4088VE3NUCp9yxSF/tYRX7FoK/tZRTdE9Hk4DXBtfdeLHmTGMsa5kW
         8G0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780059152; x=1780663952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0Dxr90tSGN8D06PZxqcdaObrRzD2iypgyadxATbBQ=;
        b=nP5RzSDt1lEEnviNJqjBSaThTs0bmG8qYg60QaXoOjXQh/ezk5OmmFNoWEy2mBToha
         gLBGgewKC6hIW5l7B3NbPJEq0N3Lu2G2S1ZNryO+cPwpySQ/i/GEboLKhH/fejnnOTpT
         SlovXwonuW/7NSD+/zoF1rlWb7DahOa5eFjcFaYCU6qYFLY1vXinATCWqMpBtnMFX9EI
         kzHPi1qYhmSn4JGI37sicoGtGUPhaWunaTUOOyfFv8HMfz9PAQwTKjsNDxmWNXB/PUYY
         rfiQ8buLEo7pnK+/mIOHFjIY04HlLCtqh4XQCWyLj1VgozUoSYOiIB76vUG9oV1/ece4
         uPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780059152; x=1780663952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N0Dxr90tSGN8D06PZxqcdaObrRzD2iypgyadxATbBQ=;
        b=q85SvAbbVfHcEr0s8L4g2DVDotqGbu4al+EfzfhkszPo2fiSJduNCa79lp2gtCZqSr
         /BKLaOsh2dpI04iFMhAZo8rdO+U8bVeI4H2CfhjiZGKQCXgfDnwjxRV427XJt7Mdli4D
         OMOXo2E7Bpx3U6DUY7GZiTyquIw4GOnIM2VIiaOfhmvrW+wK/5jgSsSGJ9p5W1oVXjm8
         cyHFARWz4CTzOOjvvRe5gcsuG42zS2hHW4vlmrWedskYYRQSPuZ0fw6rZ+tSa0tV5mid
         sPgsPpatmtq38G1CHlzOpcYr5XLldhVLJFBZRoq/JegedbtinmyTcIUHE42XDTmw4Ezt
         J/WQ==
X-Gm-Message-State: AOJu0YyByycuXMa/2Hxnt7+LDGyXszV8lLEbpxdxyd/SfntWqEkrqIpZ
	BWJn+o9QMDY7FZ2slwiXhrEezYYSKIMlaJmZUKJhbk1OQ9Al9K7qQYPwlkp9aw3jot2WcF4qOeC
	4KCB+72zmXF4pjh1RvIlq67K29aKT97I=
X-Gm-Gg: Acq92OFknP1pHs6JpDihPMdEpddPYNeEAXu9K53q5H/4ts4oTHK18D4DdPOBzXwjjMh
	JzBdqc3NJCQvbyUNS28Zf984DuPYXph/KAk6I5ho50b7UZG4n9bt1u1STjK+xyqLfD0kzQrWD47
	K0q0lfPJhLya1GIjy5wz2zGhlQiVbbXQbTTnldpiE9NBLAMZoRV21LMWAB8K5GbhAvmwp1WVkvp
	SEzPwBtQ/euNq2/1d6F7Y15OvdmsZXVZXEKtJj8CJoRbRE7vvisA4Hn5QNICl1H9AHal3UGx9zr
	eEO0/cXQEfKIWaWWDk9uWNd+X8AbcHs5r73fMiklfONiTIEURKJrNjn+qyCdMoTZ0iqw3pCMktb
	flzQX9A==
X-Received: by 2002:a05:7300:6c28:b0:304:cefc:5fe3 with SMTP id
 5a478bee46e88-304eb0d7e2fmr1270278eec.18.1780059151866; Fri, 29 May 2026
 05:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-3-kimjinseob88@gmail.com> <20260528142803.15e3ff83@jic23-huawei>
 <CALMSew+3RVXxLJYtr3HkV7UeAf6Mqx6PpA2CehChoVaMFddpJw@mail.gmail.com>
In-Reply-To: <CALMSew+3RVXxLJYtr3HkV7UeAf6Mqx6PpA2CehChoVaMFddpJw@mail.gmail.com>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Fri, 29 May 2026 21:52:20 +0900
X-Gm-Features: AVHnY4IH03ffAVGcDvOGGjSAXSpJWUGRln-tfw0E4es2Op9aZsxsbd9lCLC0GvM
Message-ID: <CALMSew+gVfGS5RJN2ccYiF0Rs+Eia_QM1xJ9NU4=aXubhTFTaQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/7] Documentation: iio: add Open Sensor Fusion
 protocol v0 reference
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry, resending in plain text.

> Can we have some background information. Where does this OSF thing come from?
> Is it a general standard or something you are personally developing?
> Some links would definitely help.

Addressed in RFC v3.

I added a Background section and public project links. I also clarified that
OSF0 is not a general standard, but the current wire format used by the Open
Sensor Fusion project and by this RFC driver.

The public links are now included in the documentation and cover letter:

https://www.opensensorfusion.org/
https://github.com/opensensorfusion
https://github.com/opensensorfusion/opensensorfusion-hardware
https://github.com/opensensorfusion/opensensorfusion-linux

> s32 given this is kernel code and i'm not sure what else this is referring to.

Addressed in RFC v3. I changed the kernel-facing wording to use s32.

> Not sure that is meaninful given expectation that there will be channels.
> I'd describe it as a payload header, or express this as 16 + 4 * channel_count

Addressed in RFC v3. The SENSOR_SAMPLE payload is now described as a 16-byte
payload header followed by 4 * channel_count bytes of s32 channel data.

> Is this spec defined, or just what the driver supports?
> I think this doc needs to distinguish between those two cases
> more clearly.

Addressed in RFC v3 I separated the OSF0 wire format description from the
subset currently supported by this RFC driver.


> Is there likely to be a non trivial delay?  If so we should figure out how to use
> that timestamp to get something more useful.

Addressed in RFC v3. I clarified that timestamp_us is a device-side timestamp
and that the current RFC driver does not claim production-grade host/device
timestamp correlation.

> What is AHRS?  I'd spell it out.

Addressed in RFC v3 as Attitude and Heading Reference System (AHRS).

Thanks

Jinseob
