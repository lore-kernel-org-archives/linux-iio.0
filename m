Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603430C615
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189097; cv=none; b=G1M8ro5An/Y5ZejAE7aZRDPqT8dZNLwo1OCkgUcXXt65j1vsGSelXX9Dr4QR1S2Hv0XzePDXLsq//XUboMnv8mNh+CRHIHy0RLNeJAG90axOhi39R60hch2fuS+jfPNFV8HPrzv/+nixS2pto4sVU00jypZ+KUrrdtbVhOyObRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189097; c=relaxed/simple;
	bh=d14NjL6TUAAsqgHD4vIJJ2NeE/xtNU7dJEoouEAWEEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1UA/Oru/tC/y/T5D8Tr5U+4E0LMRL7r4hINN7HcLHIx1Y04ZXG3kO5S30SfScv13J09OxqZXZiFIOv8aI1ezATFKvi2Z7StybFkflqu2XUMEOvR5pcYPCXlx0Hv/FnxnE/QK+9EJOEYLkZnohYKwrvGYlaSgor9vrESYvlzW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=n5/Y0iCk; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="n5/Y0iCk"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47930edbc7bso1197970b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776189094; x=1776793894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwFLRWgnSYIiUfJhzR5C7sJtzSx4H5hgea7vK363pWo=;
        b=n5/Y0iCkj3Yo5feKGUB2eDpz0q258iXzr0R2QduLqdfgCR6yOk4dIOtr8CUOm2HgI8
         Pgm4vCz0rzPSojwfntaHkYuKWjxd8dsGvYasZNRZUu5klbtWdBv9TJh7xXVDxqrW0WHo
         AurbDq5bp3WbzxpMQFTr4FpLXqfQB4boC30ZzMmfl4ErDVwCDD15RoD+wUMXcbzWuY2s
         Z+Ufuxm7UDcwnJbum9Msi7e6H0VQgBn/9ufkS0Vtcvx65L2pU4C5I6SP39bFZDdtb0+7
         4UsENmYrrFlqQxj2YYOU+C8RErFV3Ou0T0y/dywCEMQhIW5qDbg/U0G/Eljhx0aBW6sn
         f80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189094; x=1776793894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwFLRWgnSYIiUfJhzR5C7sJtzSx4H5hgea7vK363pWo=;
        b=pETuBFA4iA0NeJuKo78EGDr5//jSjWYYjcAdbe9YK+9vD1T/NpI1ffxunuAi0fLmiI
         pa+wWN4b2LJn9c28+lIPUnw+jwgLlw1HA6AiCsxjVeBMX4+J3+hW3f7ev/CtUfm3HiFT
         UFXgjhmcYxAkMdVpe0CFZ6xUs9k2W1X4owcrKlGIBcNgLRtdbvzRnySZGL4pn1UmHn2L
         HjFnaewQy/x+Lm0CU3rdKlR/Y5ej4Ia241DIA20LRQilnNQ3i7mEi03TppSJ7aSQU7oa
         1N7JRzpvmDszKRrpqn/TMIKPxkDU6jPJ+0xr8tVimM0LqXMQZ2W8WRB1RXkDMTxsE0W4
         Nt+A==
X-Forwarded-Encrypted: i=1; AFNElJ9Evy2ppJLSLVCJK7IhbDftJ4c09w/bXOdAnr7dLGj6naIhpsv2RTWTQS7M2MFUZdPbAF250OPBc3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlBdWg5oAgFL3kECDzt2cLW1tzO37C2F1u/CIP70lUHDJhT7O
	B0D6k469x54sWJ1q9LSmoQ/dlYTOwJMmsHAYVnHzNjapz0S1yen92pSV09oIile/ylg=
X-Gm-Gg: AeBDievfpoFvEwA0YxikUB5pWjIsQzp+hdaqXGSOyLU7NfqqoHBWTv1e+FpV2zZqbx9
	3KIFbk6890PdwmoOhx3YFTysNXnMmRjzuPzHFYO5fatTXLqELXjrbfCTS0OZ4j8lAHs3K4RZDqz
	R6z1FNHc6Uwuh9OEDEjGNaCu8SIpUTVV7mGVncsF8iYwHoizruEfytY2Mx5BGAVfG1a/gPNnj4Q
	/Ns4GAPd8PTIgVFeC/CvLC0/5yx1peKIXBBKrzOWfixWS7kdXU7kjiLcRhsSXhmuLmpAhlDDLKg
	U3tG90as3RpU2TlXqgELQaLzRp+MdNZ+odtD8E6Io/o+Mk2+ohonroWKZI0eEDU95R7A2NC0v31
	+VYNXn9yqYYxtz/pArz6U0ubSKBFaUCmYpFLgqViDo8kvVgm/tn/BvKHePm3qANk1318maw9kYK
	AShxM0WPET5oNHBSZeolsI2b1Pff5PAkb4ucbHdQnJRwQun0cpVYTPs6wtL7xt+jZdO6UcllylH
	H8RLxwgF3H2
X-Received: by 2002:a05:6808:10cf:b0:45f:481c:e258 with SMTP id 5614622812f47-4789ef07666mr9746716b6e.16.1776189093887;
        Tue, 14 Apr 2026 10:51:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb9c461sm12107675fac.16.2026.04.14.10.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:51:33 -0700 (PDT)
Message-ID: <b9c61657-bed5-41ef-9dd3-e2fc04a4785c@baylibre.com>
Date: Tue, 14 Apr 2026 12:51:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] iio: dac: mcp4821: add configurable gain support
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20260414170309.6151-1-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260414170309.6151-1-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 12:03 PM, Nikhil Gautam wrote:
> This series updates the MCP4821 DAC driver to support configurable gain.
> 
> Patch 1 fixes a spelling issue in an enum name.
> Patch 2 performs a small refactor to simplify state handling.
> Patch 3 adds configurable gain support using the GA bit and
> adds support for writing to the scale attribute to select the gain.
> 
> The scale attribute is used to control gain selection. Writing supported
> scale values selects the corresponding gain setting. The implementation
> supports all variants of the MCP48xx family (8, 10, and 12-bit devices).
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>
