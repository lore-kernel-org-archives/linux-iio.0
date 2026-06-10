Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068913451CC
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130486; cv=pass; b=pCeKhGbXjlu590fQd/VKsyQN9UvbK27Av7hOVHCbEGkUc3K72Nk548mkILoqbW7OvsqkGnB1N8jDVawcybDgvDt7ALvCcjiU5psLjn2PWBsmfSJcLlsh0b0VNe4L9/D/+AMO8S7c8GvaXlL0nDMAcub+mvYa7ZdrZdVezF4N4Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130486; c=relaxed/simple;
	bh=WZ9MJIxuKOMQy7uNUnOgdCvwRv+6KTa+DgUhgZlwW64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4jb26mCEzih0E3vhQmz00SaeNQW2Su01nSVzUJNtaEM9jXypQYMrRkwcTRSoRLlE7cdAgLhJdY/MI0sq0KKnB9SqU0VPGln14uX4mK6eJVUZLSOuUrzMUslTXpxh3mI44vxwieApgZ/VqzjxhPdj9a2FVDbImc1r+/lX2pLK1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgGOzyHA; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgGOzyHA"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6603d8697d2so7214050d50.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781130484; cv=none;
        d=google.com; s=arc-20240605;
        b=N2Wa2EEvGei6iha5hZYD74DVXUngX0mK5X3rPfRa7SbaSUTb6nGGiRdiKrw+2bnWBB
         D0rvNajG9qmcibaaWHJO/duh3yXEMayp4pkMjDTk7IgqcsGfAlIrAjRjrfRNUYkzgE7T
         WX9yAnFh8ipsKzOr31iN/4qkQSXjS2HAjS024y9pQziKtnT/eFdnxh7ZTPns21wpHbhC
         SAlOcK/WFJbJwAOq6XBZfzbBEvmnL2/8OHNf+5LZjqsFpW5VlFYE1TUhh2yV/OAmfDjN
         XUPaJeW2+FbaIO88tmL8Z0XpaN8d4jNJtSkKvsA8kGent9lW1BKD7tfapOqgwj4czLfr
         WNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRFLMu1HLCEJ5AMI6v8dDlejU3ZX4WM4suHtV8z+4lk=;
        fh=36mK7WtaxqpkiUgm46gztPB2G73p0hYGmQQxkgDsM2E=;
        b=fOj/pS6nfRC7PrHlNnQD1hOxdFZkv4gwZrbOhwLn26etophJf4EeYd1ftYLWOsQYvb
         ntcZWeLdwDSiRF2Qryh7UIOe1/evkZR7QrkoQxF9RwF1yVrj283jw8pfBxJE/Y9NNTmo
         T+Ki88T6A5cOV+UvPv0t1WF3II6hccRGTJpiQMh46yFCT2Brj4CKbxSXH+ayEkmTwjb2
         KaIvJy/K8+UGuN+MLOQblR1sSg+w5yyizW1C6h/b/o2ZDEZXjuTnQ0Z1swtw0mVmjAWz
         U3873EahjlRUSAyNOPoUSkJnxAsqstSfA8BC7lDve6ARdt3bseOE0pOu1cDsfFszOik5
         iS1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130484; x=1781735284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRFLMu1HLCEJ5AMI6v8dDlejU3ZX4WM4suHtV8z+4lk=;
        b=MgGOzyHARRXb1L58Klm2HpjFpfvLw2yLZe+zxu5AY7SaQ24JVHgd2AZxR3QnNqUNHc
         rp919R41YDrVHN2bhZxtued025owNpEoXXbVZYvi07juhNjrSaqFuR29jkXzxm8ycECJ
         cve05VV655k7SfN4XCCbutEcpRtDM0j/DjUXS4lYSd5sNRhhC3ccR5+LdpLpVvAR48oO
         8Kd7DG65phgYB+IvZo8KL33K1c9axc7W8cFQIkqivFye6jzmiaBuOkxB1reROAER0kw8
         Z/qhAhbPURvbbGM/fStz8/SWobUeXoY82RjpZet1XwtJVk7QTWAM5mYFPJi3UTsP1shC
         0GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130484; x=1781735284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRFLMu1HLCEJ5AMI6v8dDlejU3ZX4WM4suHtV8z+4lk=;
        b=DybK4vMtvu3WXzhF3Ba6nfY5C8eKTU8ekTl5ALyhfxXq8A+k2X5Z0+190Mn52/TC5Y
         7iqWxZVUKs8tdtPH5krZitnmnse7C1zzjBaCxUeYhTGE6VByB6/PBr2qQpLb8NJtlBLl
         eRRkA/oUDbhP/Q+l63jMhsYjmS5UN2y4GJfubk7qOqon4McrIElEWcJtP44Bf6gu44xC
         v08dPBGrE4SyT6SQTDXGLLzPxk0lxzhu7l7JAHbcYTnLhX4PEw1IpJaHi6HoATCQQ5G/
         KmKyEXUfKAUfDNgK0G1OjVeez7+or31vDg/g86ueCdE4U+ph8n6YyuGe373pz24OICVc
         aUtg==
X-Forwarded-Encrypted: i=1; AFNElJ/eTKv6QvW6eCrbY8t30zSC7XTsuz7+2cw7akg2wCB+tdDyBugOWEVPNafllN+aNbi3ReFwfVlUGTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jb/EhHF6whYhQEUndG6OenaXTWHjdqTbAHwmY1QR4n8z/WO+
	Dmx1M5d9y5V1Iu4EGY4h9q0xWhCbXcjYLr2MyBb+/DVAs/HtkMERREA7bkZKWvbHhWOP+wBhmNE
	SAARDxi20fi+hG/EAe37Aes8G08VZ8Lg=
X-Gm-Gg: Acq92OF+/KbBYtvg6TrV1FcvBmGfvSBqZgqfLsBPeymK6VY+H7vaEDYCxwRx+E0wbQU
	JxFYV7vRswwy01iRPAvriWUIdnQxTlXPtxHvAW3tVHPgulgCF1kAhXxbr6OuQzddncwRsROZ07r
	fN8NNe+Cq3h18KWjZDKutr2G89WKcLxeZrnCxns/RV5+ZLuO6FzM7NgICmM/sWWWCD2RWpyKrTv
	g5ZmWZP+4vMEZob4dLYmfrWucLY7TIh4/p+dNJkjbKeq0MkK3D7KqOifrCk7owmYtMqOyC4LLCq
	VVQFG4PsnYtEq+w=
X-Received: by 2002:a05:690e:1686:b0:660:a41d:d180 with SMTP id
 956f58d0204a3-6614f5f6fe3mr9370676d50.21.1781130483950; Wed, 10 Jun 2026
 15:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609161701.52513-2-m32285159@gmail.com> <20260609161701.52513-3-m32285159@gmail.com>
 <20260610-silver-elk-of-eternity-2beed0@quoll>
In-Reply-To: <20260610-silver-elk-of-eternity-2beed0@quoll>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 10 Jun 2026 17:27:53 -0500
X-Gm-Features: AVVi8CelZmi1gbmk50cmRndMjrxvlM8y_gHhzYrS-VpYfxNea0m0VM7sDeWLV_s
Message-ID: <CAKqfh0GNcOAtW2wEBPhKi2GwdVAJNGcgjdJVidQYvOF7oJ2HVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: sensirion,sps30: Add myself as maintainer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duzsynski <tduszyns@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:10=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 11:17:00AM -0500, Maxwell Doose wrote:
> > Tomasz's entry is no longer valid, as he is not active anymore. Add
> > myself as maintainer for the SPS30 to replace his entry.
> >
> > Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-h=
uawei/
> > Cc: Tomasz Duzsynski <tduszyns@gmail.com>
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml       | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> How many separate patches are you going to send?
>

Sorry. I guess the reason these are separate patches is because these
are basically across two different subsystems (iio and dt-bindings). I
ought to quit doing this.
