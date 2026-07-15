Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6D42047E
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120514; cv=none; b=usXBADzCTThNtnJucRWhM8B3zmGzLv5knSZI/DEs8AaYc1o8JyVCA8WHJLcTPdSfGJl7j1Vw1/8dltXUBQjrY0Gfe9GANeAxq5SD0QFJrRxTwH4hAb9X90rtYJOw79ohJbcK+V3DeR8nUxDhgFjzW4st37BMf8wW0ShA7p6yrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120514; c=relaxed/simple;
	bh=eQ2gKYc9XnJfTD+PUNBgiWdqiXRs7D5irdfEB56YBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpxvNx4yl+ZL7ckxSvZf0JVlCaUIFZGjvzZ7Iy4z30mj9cWxVzcSKieCYRM2qvprngjvjYov9Bn3QRxj/b70MvII+lX8Dq7JxWYpVH+A5oSASkf6H/pVDYcDqYxT+WNtBF6lvdDYjxSmtrXqokiSlFuJC82Fwr0S7qjMO5Mubog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxkY+4W4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxkY+4W4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso2982211f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120511; x=1784725311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cP01oA1jkrZKwxr5XPjzYghqVKBxOj1lEgy0fuomJtY=;
        b=LxkY+4W4zR0lOH/X1hnsj5Ph7Z5Bg0Cx17K4TZC98Pe81O2hvchn7vU34Xz79APavO
         V53TCKkLg0E6kVzkkuxb0s+bv3Bj/IZXY0IEsUslNftB5LrpqSJmV9Ot627VEvgbO7dk
         CM3myTSPlr3qMrTIOn7n7JikEpIzcnIQOC9ps+5BCEz2cAi5G0y6glu1buCsU4CDKKyX
         61D2mLF9OZOBf+QoJGiDWJv1O0zEtYtlDQ+wM13EhreOdXsEGQLWM2B14nuyJwICasCQ
         TZMDAiGmRa/CF9hGFcilGHFPApDXhmatrdJd7/ZRBy8b/iN7zi35kXhhQoKLuz9s9S83
         +Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120511; x=1784725311;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cP01oA1jkrZKwxr5XPjzYghqVKBxOj1lEgy0fuomJtY=;
        b=VuXdGaUDJXXuYt/O87oyx7IrH/fOoDkOPVdKCgXoIYlFbEtlXEu8qClJEVPHoGYJ52
         GzjjoDkdLjwvTUAGBbsxI971RqVEMuTDVwpNfK7u3Oq+5XN8QLu6KgYwkYyCHBlumYis
         /HQzeRnrdtvFnon392KceAcbCXJjbsMhi20kmoAWsGnwOhbPW2WRgtGdfQSEwqPJQsnv
         aes7VJxUEpaptcDk0ApdBGWfhwylqkpkvwBbTGvWqudECBHr+mWV+ML2hlgL2DYTc6bq
         z/YGgpCeQogQY4SaLM5oHqi9kH0ByNBPXyI6b2cDeGjz//qDVP4M8fz2efhgNdIQblgp
         g00g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+bMUbbtGTKmpHYKwItZx0+QhPzUwrxcQIIOe9PI93usG685vmokWHAGwHJzli+nEatK2gYE/Wx+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRPYqwnkFBvepm+d5RmOUnpQr6E/9CITabTdrjWNFSoQod07L
	W9DGdGts+lfMkv7fbLBjUT65JZTHOm3zLLkAx0iVAnaTwrkLWYB8QPyu
X-Gm-Gg: AfdE7cn1V1JGyKEcLssNDUXvxIOMO7ER7N3bykumArL+k3GCZd+bD89Dvl+7I7MLG5u
	o4CcazzFnHkwfPc+BK2Se1rt/RFbqywKpJMV4kcvvtCuUDDVNFpY83H916rMCJ0kokou0Vk1omT
	DDo6cd3AI7fwgYI2s19pNDi61PPZY97rYjgXO/+9v4tkqAjfU08xi9n7tkGXc9rrSru+JXhLZTX
	56ayWqoqs7JGOgHF09OtR7Ec3rB+I2XTSjf830nkOJJhvz4fA9G8JpWoLwRAduEMK3j5Rhm4Zv+
	5ATLvXi6MJ/uSnyJgRTJEmGZ8Z0EVJ6erUs57Q7sMU2u/4RNzb6QuYFGLuV/sJTWtdIgv+OU/qz
	enXNS/Z7fUr5rw1nsOnWg3t7UEsJTEbRzr7xkQxdGYMntEgAwFzx0sRoJ/tBybqMubOBEZpJvDU
	EZ3aKSlgrX9WBXDV3dcVgTnEAQtM9rzTBlouHpHDRNt8Os+ORTriosxiGO/IlZRHNkikCbcCDlz
	iBX5Wu7PrX0dmonnQL5idzZBLzDDw9l4o0whcuiJw1zjVsZnmKuOlOkJ9s5ePeX4OrxA84PFv8v
	C0wU4qoIRbl1Rt6PGG3c5h2Hiwc2s3mHujx/9EUA8zKc95p7Xy/nkD27d+YQdrRgM4cjnEeuXYN
	D5hVDpxfFyZSvbL2QbzocC5g=
X-Received: by 2002:a05:6000:2c0a:b0:47f:4893:d180 with SMTP id ffacd0b85a97d-47f4fcbfd0dmr2975258f8f.21.1784120510933;
        Wed, 15 Jul 2026 06:01:50 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm16825947f8f.35.2026.07.15.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:01:50 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:01:48 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Martin
 Kepplinger" <martink@posteo.de>, "Sean Nyekjaer" <sean@geanix.com>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Message-ID: <20260715150148.000045ad@gmail.com>
In-Reply-To: <87bjc8o32z.fsf@geanix.com>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
	<20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
	<PLKuTyVcES-o-CEsU7WA3Ir7-phI9WLM9PJ5UErJeahWgus8heVF4GPky0SC-EpaHLv54lZya37ivhub3W9kNQ==@protonmail.internalid>
	<20260715104542.0000433d@gmail.com>
	<87pl0oo5iq.fsf@geanix.com>
	<0RfJ6kNIpjdTDIh2uWC-FK3HRObOpQWqSWRm6hTgOFq6_wdHDyRfpatKMsvApvfFc0r-ye6piEWG888mBhp3yw==@protonmail.internalid>
	<20260715134053.000012d4@gmail.com>
	<87bjc8o32z.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:21:56 +0200
Esben Haabendal <esben@geanix.com> wrote:

> > I'm not sure if this was intentional or not in the original implementation.  
> 
> Ah okay. I assumed it was intentional, hinting at the hierarchy of the
> defines.
> Should I flatten that, or is it okay to leave it as it is?
> For what it is worth, I like the current format :)

Up to you of course, nobody can force you to do anything :P

-- 
Kind regards

CJD
