Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BF2D6E62
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771668191; cv=none; b=Vjk+o5L4Cio4PiVRokpRb30vo6TKYJxQYN/5MlsmXPU+bns9hbxKm6SGscJaiopggScMLQdJ2JpChQHGQCAiCItaLrgnw8R5eutgIivCiL0o19JcgL3W2VadyrC1to4UURWZV4h9rezm6V+2ZTC+v42NbeF4YvpF5zvomxbIQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771668191; c=relaxed/simple;
	bh=XK5QLp3a2c3P2hJSp3xXyr4epCTVdSBF/sBEGWbtrcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDbwwDF/+B7OQExKmoyLuw8B38Z7L6CApNM2pY3+xwlsf4zT4seLCYTQEol7r6//hKKiXqzk2bg4UVtKN1GfUdtHVqkxUeYEYZncwDvycdMh0dZ5cxswnJwLdIm0fRtzedrfpAj5bzRXtgcs/nD5rfr8Z2zi2iFV84FniGnU2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpENzgRB; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpENzgRB"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43622089851so2846092f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 02:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771668189; x=1772272989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svU+Z2Vt8ux3qugTk0J3lgz49Xbqx4CIYmFlgYC2GFg=;
        b=tpENzgRBlaD5msNPz6McxavaX676p6X8aBvMBsym81YO2A6JXJCwBhAYKShdhLZ2cH
         dYog44AhI89tCtQ/x7dM9rm/M0awsIxkORifWydzoLaZsuLPpNzHVprJczZd3+WkGf2q
         crd7hznLQuGkAtoiefx0708wpmUH0LwUeomzMHPuUWFqOEucojFJewfwluFdFKKsz58I
         6xuzFjQKRSQTFUdQj27vILKzkulm0/gQFvyewjPfnoEPlWTLG7OBDrJeqEkhkQIcNUtB
         wwz8R8pqBOeOzleb/RRMjspqm/KY4FxHueEBRBqV8Adi/8M7jopHQrBP2q5OVAOxP9a6
         /tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771668189; x=1772272989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svU+Z2Vt8ux3qugTk0J3lgz49Xbqx4CIYmFlgYC2GFg=;
        b=FH/7rmGkqUXw6eWJ5EpbShA0AhStzsNUanNU/r4F34LymAvpoJAIhAthP8fAvjQG3R
         q4yF8OF6vC33MxjhdR5pEw/qStGcyUP7ko8cWp3fcz2SYyxadwlLlSeyozPxIEL1a64s
         zedD530GKPbGUAVfYHXInXMdKGqvxA6yA57Kbfzc9YwJXasCZpV/myT+I7NgRC3Tzrw2
         LQWGJ4SyGdoOoJorhE45kwXVvv+tDNaPqip3HkZNv/uDfeKST6KkrgPGMj3wrouCJ/6P
         C7qFxKu/A0do2DoPd93L4Ht9//BtthFT1SfOjmApDXH60eUS/QKqAf4LYwJG2dnL27MG
         6OHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz5w9JpTO04LRw1IOR5IiAMmb8XTzdIa4JaGg8V4r4sglAcvyuROW+jFMZufXhPkzazd7dwMCRaUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMEsBQgDWWgPpiVxYx/K05d6MJlRjjBK7daYl0Sk6kVGhtQkB
	mw0PO2VAdf6mmx3yINu33c+QuiMLPrId2B2G32QR3krNMnVZjX85ZW9mw3M61gxw6H8=
X-Gm-Gg: AZuq6aLQMAx/ANMRCnlUjD+5CYOryYEJkauZap0esguBvSN4vp1j/fJpltfSluIvvJO
	fsX4V5Cz9bIno2mBJ1HRHo4X5rPr6CxPwrITbPZg0BStVwIruRgHoALSfZYSlpTv1wJw3ao8LCC
	VgBvjEJd5XkwX18KCO3UuettrY4NcTT+cfYYKhWhMS1khVQgPYSoErKzgwXQ6yK3yIgqGDSm600
	jqimF1Y2H41YO8yh7bH86gIdOl5ZZB9aUAZJEK34MbmMI4wuHa16WaddLIwDEzTmslWRT74yxTB
	RgyNskWZr447oTDg0JDV0hRT3QT9qBq3QM3jQ54bX8VTXkmFOtemhXRrVD0ne+sMA6joVIOZefS
	o05c5+4oI78OIFtsu/nEsh0Qo2lVDt64zaqyQPhPYO3z94lCBK8HMi6dVWuHAJalpNDfQQz0bh7
	WSa/p+7sYW8lC/JBueDynZ6DUxSSXL
X-Received: by 2002:a05:6000:4211:b0:435:a52e:7758 with SMTP id ffacd0b85a97d-4396f18a617mr4532872f8f.57.1771668188524;
        Sat, 21 Feb 2026 02:03:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54c5csm4325859f8f.38.2026.02.21.02.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 02:03:08 -0800 (PST)
Date: Sat, 21 Feb 2026 13:03:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging:iio:impedance-analyzer rename camel case text
Message-ID: <aZmC2FvCVNNw4j4Y@stanley.mountain>
References: <20260221091424.56822-1-sainiharpreet29.ref@yahoo.com>
 <20260221091424.56822-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221091424.56822-1-sainiharpreet29@yahoo.com>

On Sat, Feb 21, 2026 at 04:14:24AM -0500, Harpreet Saini wrote:
> Rename camel case text. This was reported by checkpatch.pl
> 
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>

MV are a billion mV.  milli vs mega.  The original is correct.

regards,
dan carpenter

