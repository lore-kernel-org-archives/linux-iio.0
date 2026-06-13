Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716F3546F7
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781331815; cv=none; b=OMkXSn4r1nwbKimmpmcMKvpMnKyEiK+/Ek39XEXoVR9enFaCUqy6B2Z1PQ7rGh+dasUii6LpTpv8PSEyyV5FY1kQ8qMOfaQqCORpdqDgje0PaV/6q550nNg/CdauLy8eLPN1jH/VLrAgulkyF0gbhicG4VZyehpIcalyQeo6oIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781331815; c=relaxed/simple;
	bh=k5G02N1zKzfIjIVmFuEqHkT8drwuzrUmLQ3UCGPXm5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hlyhI2tDK4+ROFWrw71aBrGuDRSQNLcmoMyXmD01U798pQ6M2mOarJjSmQ3SRZape8VroKRflg+hVCKqvltN88eIqkcNGJwXLad/Al407ZhrnHw1CH3m2RIKSQtvSm8rzt3LsOOsx5YcKWvsxdVulBv8z4N5S1nGa+4r/BZHsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juhxLx5J; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juhxLx5J"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59eb57ed4cbso696889e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781331813; x=1781936613; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5G02N1zKzfIjIVmFuEqHkT8drwuzrUmLQ3UCGPXm5Q=;
        b=juhxLx5J8zYDQcGQreyFHgYc+i/xO8M3b2cPSJc7ti9UKUMcRkX9fGd3wBv0IpQcn3
         WBUbydMX7l+mfx3vu3ddEurmOBnnKlw5JBoytQ22R+TbeHyvGjqstggTDheRAvXIdRKn
         aeCdHXFoyQ1bicb8Kpu98Kr+ro/toay8eGIZoKu+kiSLJPqa2RIEAWUgnnO2Vj9x1Xpb
         cKUZ0LMPI4VAB+yR/wWJ72mFakNW9iQ/zzkjdUlSSrKjowX5pkbURX0Hbn8bCcHAc8zW
         n5MJYyUIfI6AHSHXK+ZWWRS4BE3xbUu5+YZbYWtVjX5ilSjTvmMtty83u8H1kAmlA7NX
         A8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781331813; x=1781936613;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5G02N1zKzfIjIVmFuEqHkT8drwuzrUmLQ3UCGPXm5Q=;
        b=gYmI+enNWzaNykNHulfN5UZoBBAKo6qFzPaz9Hz1gZ96XLdJMbwBzzC7gAcEwwYFDC
         q5Lq62nlUZiR9goexa5n6pp7RZtDWs1k6yhz/vpelFcIgI2PHEP03MBhBuqsL3DQwGJL
         Igli7ENyhh9anYJ9Kz0Amu0I6nicG5GU4kltGtD3cBh2bemCpLp7PDkmq5wW7cQahwJp
         E95xst1Mu/OnOMlx6jsCSwG6Sh/2zsHIrKHoQE+kEJlqy7GaY0bJAVhkci59qen3Esns
         oqXR63xtL5Hw1Q0NdSeTvizsO1YBZKRpjfkKYYiLrh0MhbSF9qPES97Ag+YYzJ414eB2
         tYmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vGu8s4NJU9IIgweAWHH+Iwcc5zjaq2TFTF49P40oYJwRxVwn7RS7HvspVtOUl0/Owt0eYUV17FLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5y/N50W0FDIqvCItQ6kIQZGewqlKhQVm4NHM5LFp0NfmSmAg
	aYCsfUjPY1dNfiuo9xztQ/+E/+uF0g/Gk6UjWWgPIhH5LDmXSEqC/G57oi6QlQ==
X-Gm-Gg: Acq92OGFRobMjVjevhtOhE6d/Jvp8lYI/4mUExKzhDX1+dMHsA2dy6ojLoOiBpyKrKX
	rhDtWBVoNGWDj47v7fV/5a0PPn7u1iHOftGNaoCbFQlFWG+t7IuEe+2BPIHXPTqkLQUrlx6aIfE
	ED2mzsXIAYioWOtY1QsK5RdfXx7X4YdYEtwYhzPM686zqVVdxW4qTXfZGmWUhadxIbg6ndzvybt
	Nqx789kk9dxxZjPYz0IvFzMy/PHdAkWz+mKCgF75CO1lhK4iEcHsfdhovtZDSYl1cR+fzWq5QUh
	8azpkcbG8M1HretyrTev4VdMoAKNTf12EImeMTSOPMYZ+qqHTt2dP1n6ptyPXmzUEJ58HkWB7LR
	Htz39QZqi8wvtMc5qaFP0HH0oX8TSLuljAQ2oQebm+OqZWA2xxmf4v6wcDvKZGiVk7xOLTy7MlI
	ie+pSQunUypmjikHsoWMF4LBwi
X-Received: by 2002:a05:6122:32c3:b0:5a4:b5ab:b5f8 with SMTP id 71dfb90a1353d-5bb6bfa4474mr3583733e0c.2.1781331813101;
        Fri, 12 Jun 2026 23:23:33 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691bc485sm5244018e0c.12.2026.06.12.23.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 23:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 01:23:25 -0500
Message-Id: <DJ7PFABQGQ5X.Q9W1BXLAQXGP@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij"
 <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 3/5] iio: adc: ti-ads1262: Add GPIO controller support
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-3-894c788d03ed@gmail.com>
In-Reply-To: <20260612-ads126x-v1-3-894c788d03ed@gmail.com>

On Fri Jun 12, 2026 at 5:46 PM -05, Kurt Borja wrote:
> Add support for the GPIO controller capability found in both TI ADS1262
> and ADS1263 ADCs.
>
> Eight analog input pins can be programmed as GPIO. This configuration
> does not prevent the pins from being used as analog inputs at the same
> time, so no considerations were taken in that regard.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

After going through Sashiko's feedback I realized this patch wasn't
properly tested and the gpiochip callbacks were carelessly implemented.

I'll do better for the next version and I apologize in advance for the
time lost.

--=20
Thanks,
 ~ Kurt
