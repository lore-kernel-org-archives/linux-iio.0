Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FC3A6B85
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265340; cv=pass; b=TtrLjlxW+Q5teuIuSIk0bS1DlL47v5q8UztwiSa2mdW9NMIxZ42bRGlkhp5Apc9/9Gkz9RBk88iFbtu0g7KiAF2/hySlIrVGaakPdcloriGY62aVwMkLtx/bL1VCNuxisRyBAQhAq31wuZh1Fk/9D6UxN8EzbmFP0qeOXt3cUZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265340; c=relaxed/simple;
	bh=JjHd0TwiMebpAy1GZrj+M2r42NPc3hgjjB3SrBSH1Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0QtaCRWxxT/qMpZYf+HT6XV/A3F31Ah+i5P0f+wFI5ZMiCYUa3718UsUbK1EiMZzHvjfPGKpTRqoHzjNYfMHmhYe5DMyU1N3TQY8jKEpeu86Ty8rAdhonc62zCV+Yv4hdAaczztZqCe+7UsCB++WdfbTWSiSP533RjPHB6Hr6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sY/TLtcD; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sY/TLtcD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-444826c16ffso4014420f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 01:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779265337; cv=none;
        d=google.com; s=arc-20240605;
        b=PB/FJGmKOaoQH8AcHAspPW6KbT7cSgTwu0kA1o91/+NYH3/qnmOSuGfxHIjJAQsu1Z
         QJ510lp+8IBBpCLs6Jh3OWNp3Nez/ETZHVbWCWwKXHDFE7aYv44nqKMd6aNo7VLlNkuw
         YzrU5zg4mH+xO2KIqQyB0LalKLE6+e0jDv8qyj2szoGfTFtlnuw69bzcmWIV0L2KgL9Q
         MkR6C0Io7VT3/bEgA+CgcCgYE0ShJIW5yzk6Vx+U9SyPsFn5e/gLvblPAZiK0glrmIGa
         vyoIHXW8T6JEEKAui8qR8SczyBVG+6DA43thcgfYvg6Uf3oQU26fCz8gm7j2X6IYzUEy
         yGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WgIjU8CJSlZaMjnikCuz4+bLiozhwEDERaN26ONQb6Y=;
        fh=wMg3oKw2Bc27Bt4IB2YeveJPQKY2tiiK4MF7nxICsOY=;
        b=kbijEg3jHBlLYInFrsULunOwPfV2+tp5LAnAePwT4Tft1vjdgaow64KpCEfwjqX/ir
         zcJIfK/tgewrrtosV6llvBdIW+sFXMzqPDWbmffjfObmQFN2z3kn4aFHxWQeQ5TA6Pww
         KqiO/wNfvWVX1Q7rLDj1c6++L4P8LUVO8Lo/2CyfFF86VBi4zfO9dObIKM/U+mVqFKUU
         wdcbBcSyu9zrBeSZG8MULq2cX1WJtlQNQgDi2UaCJ7HTR/JEo1OiNGTXeGf8OnlVeJ+I
         CU0Y/xiwiyup/hxM8rmZhF4YLCLQM1WbFUNrWnFhS24B47n5n/JDkCycqxqPzyQiOWS+
         iH5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779265337; x=1779870137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WgIjU8CJSlZaMjnikCuz4+bLiozhwEDERaN26ONQb6Y=;
        b=sY/TLtcDXJpX0KK+3KQkdY9LkVtg4RQy4e4LrDlzb8a+0erTlaK923Iowfb4CnJp0N
         bcfBexMwTo5fmwSSMERuuB4zgsCThw8yn+TIHqB3LTatKuu49f6xNpkSgrKA9vnn1MD/
         T9IZ700dLzhwXFDaTKkuhmbj+QK4eGNFsoMA/E2YiJIN9HNWtd81NTzzGIYWdSNNVL9A
         SsJBCcsmZUubF0oTUT1qU5qz2PvGrv6QeYE9G65HbjIaoMCip/hU1mUPErnRg9rr4jzt
         8gVEC2Bm5+5Pyh5jaGGRLXAP7qBmRFvfGk1cqmSptCY7IKihChebkfOMHmj/Orgg+fN/
         Plpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779265337; x=1779870137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgIjU8CJSlZaMjnikCuz4+bLiozhwEDERaN26ONQb6Y=;
        b=CveYumrEslEcaqXCK+WX/FTt0psseph+5FFS8R3rCvFRsNNXAFB9GlSOFZWQ9bHpad
         3ptM28MvoydnFXa+25c7DjWTRXMlRiLUIVmajvNykJauwGi9PR5r6SXG+VS7YkfSPEos
         M5RSCGwDYCbzB2yU9sJuQp4jkwi7Ex+Tk1qXdSUKLZNgNg4sZOozIdTcn8UTCOY9/BCU
         6S4Bx6jm6gMhb1H96abFpupMR0083tjntdbHukPzDde/YYTn9xR3akm2GN/iVdH+SQRX
         J9zR5VM7MPai8wVATerIMM0oPfcOcH1xq453JWg3CZZicxr5dBG9ac+nVbXpdUqeKUD9
         STvw==
X-Forwarded-Encrypted: i=1; AFNElJ8emlN2399L9w7LJ+gO+M/GYMfJkFxM0VOrY4rZZV6NkCnFuQzzgiaQNR4fDxDKiyXaDPny63jcTqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZpPhR0xAXfzn0CmYGED9mOgKyfSqq2q2bhX1uLVi+UOPt1on
	AOuA35HT11wsDiTtqwuydNRzMrUfarvv7jFjG81JXjQa584vQVLuxbR9W2j7zHshodUp5P6RDRy
	dNSkFL9hZ0IbtUkqlaWcwnyY5oVi4wt4=
X-Gm-Gg: Acq92OG2j8UdRHxmkT434PYoWcTkESBOTSlbW6FZnuv69PMg9qhPEjPb+LaSH9T46Gi
	Ehxn8Rt/nvN9JnddVow4+jKv6R1zrSNa/HCwjllEIJUcNhx/V4hy2ciVxqoTcjF9FniTog3gVWl
	Mdgu/W8AwpGYmGSFdCuYX+GS4LpgMtkRzVnSSZVMRvYrWOF5gCIo+Z8d5+xI6HnGeyuCMqJMbtq
	Xdope7MwD7PBHgQx0fZpZXi/ubPXw8sxpf2h95u8MkCP2RrFvrrlwRNDEsfcATvQWjAiDckandp
	vk3tQ80uXV/oIj6CEdhnMYutpGX79LKyiQtm9pwMEIKl/dIjRlNtqVjdoXF0y/HlxnmnADUlqU4
	FvonQS7cRke6WsaCMIpIybIbhj9DH/klnOHTBTZcOw46k/rxofkO3BOk+M8sYcczDPDhg3dmmjj
	aXjEFQvw==
X-Received: by 2002:a05:6000:4617:b0:45e:9433:f301 with SMTP id
 ffacd0b85a97d-45e9433f325mr2645215f8f.41.1779265336961; Wed, 20 May 2026
 01:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520072843.3593-1-kimjinseob88@gmail.com> <20260520072843.3593-4-kimjinseob88@gmail.com>
 <CALoEA-xOGAGb=-uXBv+Q2QC=viPCGUESGZw=rfoBHdEJFCkEAQ@mail.gmail.com>
 <CALMSewJinjbnHT_sOgWmHVeThv3su_E6fioyAjEWKzf7uROc2Q@mail.gmail.com> <CALMSewL560vBTut2=_x3KVvdoqMo3Lmg3WF9jr-EdncCFNW71w@mail.gmail.com>
In-Reply-To: <CALMSewL560vBTut2=_x3KVvdoqMo3Lmg3WF9jr-EdncCFNW71w@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 20 May 2026 10:22:05 +0200
X-Gm-Features: AVHnY4LOJ3rWWK2LrZxLVelyRkqyD5nwy3RQlfmXKc4pkk8Oqtwt0d7ncv9s0GU
Message-ID: <CALoEA-zx4pwxoz_a5X6yBMtNsf_Kp_Bip83HOVCWsk_3GePcDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] MAINTAINERS: add Open Sensor Fusion IIO driver entry
To: j k <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 10:14, j k <kimjinseob88@gmail.com> wrote:
>
> Sorry, resending in plain text.
>
> Thanks, that makes sense.
>
> I will fold the binding-related MAINTAINERS entry into the dt-bindings patch
>
> and add the driver path entry in the driver patch in the next revision.
>
> Thanks again
>
> Jinseob

No worries, also please don't top post, just inline your comments like my
previous reply. Check the mailing list on lore.kernel.org to see how to
reply to messages etc.

-- 
Kind regards

CJD
