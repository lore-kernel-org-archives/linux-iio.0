Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAA37F74C
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143304; cv=none; b=KE1vukyfMZ0T4F6yY7VNjc36q+DiYmbCBBN2Rk77Riman15WQYDoezKt8FB3OtimjpLp4h4bxcEj9V80cQ3xKvs2gou+AKGQt0dV1IVNoZBCrgBpbITbAyC8OwRiKmcsH7FQNHqvbYqY46fLiJ+o402/4ecDxXX6JkPLSf6HWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143304; c=relaxed/simple;
	bh=mqzUXod+HrXMUVZhR1+dl1IhEKn7WpWfFheR2nsjnAM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn8k5eCB354+ELtc8COqmnZBdZ4teDRgQq46krftyREW+UiMBGW/XSIIgycBgO4ul2UD+qUSgBMUbBE/uy5dyZdlQ5sqX22YxrMqF6ks5cpDPkc2mGKvYRHK9RrzhF3aUr7fS4SG6H2SfGHD24v8sPzM4/VlJ5+d7QVkRCvaN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrmnY+ID; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrmnY+ID"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a044cb827so460038f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778143294; x=1778748094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caE4u5rjNrtNPQSNu8xLJwgtyQILfWxFrA+ogTI963I=;
        b=GrmnY+IDwEFOTweBXURz79ZSV94KZappHKUjxUawydXw2f7HxT11QxaKPr4lL1tvdh
         3kt4JU9sf0mD/hsJD6qC8qM0EuewB9mS8WhjA7xLys7Ne45smf0TtKiDo5EfSPDSBeAp
         MMLgmq2jtkX7dchT8L/Yxnaq239t9dRMrSE0ZORxBkpvdxS7cXVo9y0FjBElb4J5XGxX
         pX1fKQ0vrhnMPQ+6jZL4kf/WQcPbI0H+k8EbRB9LRCEaNTnlhk1nth7oVC/6HZsg4uWr
         0wGfAQ6j7WItdYp3XQLs0a0ABfADWF+WLztuOoT7zyqC75Lq0FMR9b4NfdmdiOvPGxyB
         AKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143294; x=1778748094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caE4u5rjNrtNPQSNu8xLJwgtyQILfWxFrA+ogTI963I=;
        b=OZsucHCrelhICUORofDgndFywX1NC8aDOxMom1xFQRC8+oLbHnVMIDbXVL6tnDjGiT
         zJ9YwRf1bIwPFEuJhim/xifZI96wdVNMOFJ+Qe7f2yvAUBjh9XOAGG15Fu9bta3sQJhE
         WY56LQqfhDfEyIUnWitPABK+1GfSygnLRjEZJ7isE3hfseckY6sPj3tRN/Y1TE/Sf8UD
         s9y2zVMAnD2ezci0iOvf+0vetmpcO1ZiBCg5MGA0aqPGc8e0VCErGd0/zUuvtHaG8YzR
         T0I5rRKEPbUe8/G6MYHWRVnHW7E6ezFX98KR1iW6mexdwglyjZ7mreG54DxVCbjqOzEg
         IWEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KpJb5SVr5E5Ebdx+lhQfFJgoiDhPtH2NrHY7wfsiYIRW3lwVkhkzYXftIYnNwRzIrNCavQu2STd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBtzCfXlp+hjlwysQRxrXMtfPGkOTc/FPNKUjw8PgNC8TkzdF
	yD4DXK9zZYOs2ExqyPbaf9sgeS4muVfjEbF4SnOXTbr1jYOmEkTfcb5d
X-Gm-Gg: AeBDieuyhuaGNghQ54eJllZqdPOfrFQEl6xpevovbhLaBfuH0r7PMGxy3aafZFLdeIo
	/5cNV7iZ0qUtaZXYQh5jO5xiRgatHwydelSiJpXcMbHTfrm/wKg1vOA+s7wM56hHjYFQdUIfe/W
	j5wDXpHJJztpedS2MkwtYlq0f5RVJxdt47lBYI//Vu0de1aE65hssdmRaAxPVZptwO6rKgg5LPv
	tzkXnWEVcKpAysY2bKl524V/vWBjekur/ip0CHYYO4n07H08EH4Vv//1z6MojZ/8yHCkzNB4zZe
	8U4rSLr2PxgL6E9/vdGO2udCOcqEDW0Tz4cESrluRv3fpW8Y1pJdqIinnzGDMVA46F/TEKrKn+t
	e+DJ6tcWkvFKERpI5ZAawKYQQ6goivXpzUB85Aw6WCMQBZLgjfFp2c3BXaBYe6z4sfHXOJbvWpZ
	jQVTpFekpnbjdZET2aWPTtlqDk6R8DOiXeH8jdrEHp0RY48ZQNSX0hO0R43Nq7DFJvUgik51I0D
	k9s3XmqEwQBmyHfeBGRQPg18Wy/phD17aOXnaCJ+K2+J8wGstjjmE4LXNQb
X-Received: by 2002:a05:6000:1868:b0:44f:da54:da6c with SMTP id ffacd0b85a97d-4515ce1c84emr12330531f8f.26.1778143293827;
        Thu, 07 May 2026 01:41:33 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48c04sm19509854f8f.15.2026.05.07.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 01:41:31 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 7 May 2026 09:41:29 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v11 01/11] dt-bindings: iio: frequency: add adf41513
Message-ID: <65aggaxkgetu444geu4bpdp53obukzwk3uov3awe6ahq6zjyyf@cbdt6bhfjw4u>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
 <20260506-adf41513-iio-driver-v11-1-2b7e99cfe8f2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-adf41513-iio-driver-v11-1-2b7e99cfe8f2@analog.com>

On 26/05/06 03:08PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> DT-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> Some properties are based upon an existing PLL device properties
> (e.g. ADF4350).

...
 
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf41510
> +      - adi,adf41513

...

> +  adi,power-up-frequency-mhz:
> +    minimum: 1000
> +    maximum: 26500
> +    default: 10000
> +    description:
> +      The PLL tunes to this frequency during the initialization sequence.
> +      This property should be set to a frequency supported by the loop filter
> +      and VCO used in the design. Range is 1 GHz to 26.5 GHz for ADF41513,
> +      and 1 GHz to 10 GHz for ADF41510.

Sashiko's feedback:

https://sashiko.dev/#/patchset/20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2%40analog.com?part=1

	Does the schema allow an ADF41510 device to be configured with frequencies
	exceeding its physical hardware capabilities?
	The global maximum for adi,power-up-frequency-mhz is set to 26500, but the
	description notes that the ADF41510 variant only supports up to 10 GHz.
	Should there be an allOf conditional block that restricts the maximum value
	to 10000 when the adi,adf41510 compatible string is used?

That makes sense and will address this in a v12.

-- 
Kind regards,

Rodrigo Alencar
