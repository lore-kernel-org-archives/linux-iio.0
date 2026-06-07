Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D732580CF
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829161; cv=none; b=ic/aQY7T/PpCGOuZgHeJ8UyyVDxA5655/jIjUa7ygSshzeoD5TMEOkyHH0kkVSmknS1abAJCVYTlLjLwLPtqpZ6HZhQHm1+2fEBwpZfcMIhDAf4STg6huKSkfLk49i2EUX49AniemPRc2vQGQcyzWmBzkpyibbNjEkPwBtuFB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829161; c=relaxed/simple;
	bh=BXAsDyuxsLXh4hF0W2y5DY0RyBDHG49rrrSpvd4OiX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONDk5uTIAMHoz7p97xzvI+6WxMaajSIzl3oS7HHgNZ3cPadbBlxw09n+ZTttWlDuqNTBre48QmsOXU5vtyo2e/D1fyv2r2GXXr9AlcOE8sOzuiwgy5VmgChfHlI1E7W9zOFWJa8UuMWz4+HzbG5ytBpUf4TvY+mKgW5gbzyrhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYTIU/14; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYTIU/14"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490be03d47bso27264345e9.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780829158; x=1781433958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTS3KA2QIMmx3fkHZTX2l429tqGzc+KDmPG9U8abWwU=;
        b=ZYTIU/14MQr9HhqlprJNx9VwKdgQK8IGZBt1RbeTfRIqraLJMxkkEz7timTmzxO815
         +9ZfCO36vvw2T2t2PL8Es/J84Yq9PNxTkP00WUmu+E+n5s7//OYACKtynNYPNZ3ku5p0
         ngcr9DdGzGA7wD96mR6ZB5uXSOZavKeL753jIqul7hEw6YHZxzoL27C2Em0lnNxwRlEU
         uP8ICwKYE1SNdcPCPA3devgC+rMHK+uHhdhiJ8NGXTBFxYzSUxZlYFHDJX2Egc2P7tay
         fqxLaRc9lg8RhdsVT1NZixBassVFFm4Hm2FafCIQyFMiaGmAlossbYwQw5Oa+74YQnsV
         nmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780829158; x=1781433958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTS3KA2QIMmx3fkHZTX2l429tqGzc+KDmPG9U8abWwU=;
        b=RrPZ1/mR8+z36sHwK+RHtpM0EjfQyKpzEiiuhOZ0vp/PrtPngqoRXkBwi0nNvDMPbC
         IB4OGZSXVT4MMn2wrPCRKtzElMIOKVQ3XlUR7ZTY7cJIApuiJkWYuVxy03MYb5oEwX9E
         bB4wwflQmCzX57fYhx6WMhAknWe882mn0gSbQILHuem3bFs35G9aRT2R6Zue8fR+vPue
         Y8BAHJpAp03/J4cYhK3cDN5xp3FHWq73AVTbkyBjAQqQLK0DPiwVD0P+ItFJhirK6g1o
         uNjb8sDMxZJggJKhiZ9AKun1LSeh3KezfMgx2XNLWMmF91Lv4/10TkVgnLhyzAqJAHRz
         c4LA==
X-Forwarded-Encrypted: i=1; AFNElJ8zidAu7CCqJ/knVDOZMWz2UGz90/S8XjM44uQ1pV9U5tKVE+5bqGYhSCjmYjem8q/LydpuO7e4dKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtf6ZZPuolaDd8SDty3czEElCEQUu0q5yoXbj7E9C/Nu2fqRiF
	xm1aegta8IzoBzHtXPJ5sgoppcN4ijqDkqIk2NNnD0XIQLAa2mayJU5Z
X-Gm-Gg: Acq92OG/xivroiX50AYp0MOD19/3V3xa6+z4KMItBQGiTAnw/IC0MYxtJ75WCz+0tgi
	Ck+ZWGJPmM0/Mg8ZlBJ3DXOQ5gz0sdCI+Ip5TWxbrWFGNpw5A2yc9AQLKSjWNJ6x0pHG8Wu5axn
	JJFrt75G1FOh4/8Spyz075mbi20qO4Er0Q3Le3eEOtEoVVdivGWbXtNms2CcAydOau+IGaduRie
	imstO9vCALAuh99wX0RsDYIE+Q0+rZ26JEhaPEIWLJs+luLs7+hZ9I5sLXQ1oW3JoPIYNRbiZ6K
	sxOh9VuvKPylgwP4drYZa2bNMYoqXtDSWX+sq1OrvNAiaDCaJqzj4ZUpw/DiFu0I7uu6XdFg9SC
	E5mnO8f6vm93kh0dDDlUAT1kVyx1/ElW5xd9Q069VsxR9SHLYWJJ7p1RAeMPMGt/dXL9kqutgJO
	n+fl7JN7cWmEZBkewQbKxT2Tj88A==
X-Received: by 2002:a05:600c:19d2:b0:490:bb45:79da with SMTP id 5b1f17b1804b1-490c25af9a3mr187900425e9.13.1780829158228;
        Sun, 07 Jun 2026 03:45:58 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918d7sm280337895e9.2.2026.06.07.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 03:45:57 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Date: Sun,  7 Jun 2026 12:45:39 +0200
Message-ID: <20260607-slf3s-v3-reply-femto-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604094436.3c50f123@jic23-huawei>
References: <20260530205435.37326-1-wafgo01@gmail.com> <20260530205435.37326-2-wafgo01@gmail.com> <ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64> <20260601104233.310ac930@jic23-huawei> <20260602-slf3s-v3-reply-03-wafgo01@gmail.com> <20260604094436.3c50f123@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 4 Jun 2026 09:44:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Yes, I'd prefer that for consistency (m^3/sec).  Hopefully the scaling is
> fine with the new forms that are happy with more leading zeros.

Ok for m^3/s if you prefer SI, but two things before i switch:

1) The scaling is not quite fine with pico. In m^3/s the SLF3S-0600F scale
   is ~1.667e-12, so IIO_VAL_DECIMAL64_PICO keeps only a single digit
   again. It would need IIO_VAL_DECIMAL64_FEMTO, which Rodrigo's series
   does not define yet (only MILLI..PICO). Rodrigo, you offered FEMTO
   earlier - could you add it? Then i base v4 on top of it.

2) Honestly m^3/s feels quite far from reality for these parts. They are
   liquid flow sensors; even the largest variant (4000B) tops out at
   600 ml/min = 1e-5 m^3/s, so no value is ever close to 1 - everything
   sits between ~1e-12 and ~1e-5. l/s keeps the numbers in a saner range
   and pico is enough (no new core type needed). IIO also uses practical
   units in a few places already (kPa, milli-degC) instead of strict SI.

So i'm fine either way, but m^3/s costs us a new FEMTO core type for a
mostly cosmetic unit choice, while l/s works with what Rodrigo already
has. What do you prefer?

Wadim
