Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277E2475CB
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771184094; cv=none; b=LaHT7qN2LZ6qIjmpeLiiFPZGAKxDSEhyd1cA9hezEPYD/JsueShzc/j0ha00Yk4GwylklILnsggLsw3SqTooukLr5tZlRWaW6VlQUm+ogHs4rVKLRyElg1yYbTKbHlodBj45Ryt9aQ1zb1FffvYFJ+A5dWHcxSdkg+Z3krS3T9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771184094; c=relaxed/simple;
	bh=ND+vNhOmmKZdFwXEgJjFRvo5zyQyLvxZnNtAE7Sc35M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX8e7kdml5/Vx61wX9xknTJeBOgqvdleNIvIZ60zWQcaKOyuIMvyDd/RLen4TPxqkyXVQVL62UP89WCc0U9jSJQ3Ngzw0IAfF5b9nj/a505TKixkrH3jnRlHGaKWq5dNiqZuhKwoU1by1JD9ZHe0ZLtYfvOns2YERqhRVvVTnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJiK0I3g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJiK0I3g"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4837907f535so13227205e9.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771184092; x=1771788892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smgnUyl/+KHFYfvdMgtCO0R17kfguRU0f4H0nIqil0U=;
        b=BJiK0I3gME9u0ijCLFByPdREdjhEmwkI3yrTqc6biPeJT0vDgZxV4Akyb7g9+6bF3U
         vifYYSeQ+WY94vA0QtaBan5S+zHtP1uKEm6LV4WYHW5Av0vgOM3ahfbpBRRoxwxIc4Nh
         EAAP3454eG/BVnXeQnIrQy6RS2gEs+gb93mZiYTfwvHuB0RlEOyIkD2aUTT9udr8BMl+
         rRzFIUrMrU9oQU5bPpGUrknjEsTNjO/tWgPtHIyl9ZWKqUbKnwF/u38u4/G/zYOjVtyj
         G0X6JDaFFmbDd8mNsWN/jg15NDKU/fdIe0EocAkcJ8t07g9QY6ZNQ9R1o4FDWXW+vdMu
         tYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771184092; x=1771788892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smgnUyl/+KHFYfvdMgtCO0R17kfguRU0f4H0nIqil0U=;
        b=OSIhx8SVnAuKfqWQxQQF0jHlSlpqlX+Z8y7+WVJmIOW3Eo+fI6Jdtvba0813bFr3fe
         NElFa0yi1Oj6/eP85uhgrlW/ZROpHN7GxrhtXJ0myN0kQQgpANF8wZxloGjaKqkHOB9l
         Kph4O9YN/O+hPX94N0HNcw7hwXR1UrF9xTRLo7hlMc5epkHfRMY0kKacSitam7qAuM31
         INIljiCcZ3T6h1qpano/NpHkt1far0FlABKVYVgoonxZr0bcwkoVVwJjXI3SzZ/nJgML
         WjV15rqUShiPHe/iAZEhReGxJ/pwNg6KUl/f0h9Q3Xa+rbWSTp/W2ZRQP4gtG7uh+D7u
         aovA==
X-Forwarded-Encrypted: i=1; AJvYcCWKnPO/YBQxCH7LSOW6c/PTbpVJEPuxolxnTb7NTbR52ZUHIZIGhzQiUCgpv8mPWNzIN6ZisS9mCjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpbZPGl+i003nguGxL9flp2cQQb9Fsg1aPlp+D7lD3QG9mMNd
	9K/BcyeP7nPBbYynPs0lr/52E3sewL171g81SvfGKz9mXZLKJCw1B5FI1xlTCw==
X-Gm-Gg: AZuq6aIO6H/9MD3DCAYKctJTZm+dsgIgHliN3KZDdhvDgX9PqT018l2uHIFO/wZ3+0K
	LmbqXuE10Ap/ZSBmidmuYYZb0uq5HfgoNQiY2rWVFJ6/5idVUullXHvGcQvDJk/RG0G1zXETBYD
	6OL99ESBVIVzW7k4ufRfFZP49ktI34rIkYJSDCvZfqE85QtfGIxDValdzYvXfCmCckPkpXJdrgY
	ex49CqO1/Ls2izU2SEiZ7DFmfphiEAIB5XEJsSRpGFVYj1D3Au4NKVZkLqPAMa7du5QlZEpi5Jm
	DweRVwYFhRs8ON4R5FZPY9eMeD9i8h+SkpgPPkaOA3/eHsxVoB0UANPeYzZyNl9m7lBoEX1prPB
	olDjbUJZ4Y+mjbBrXtfrY79bYxfXPudbYe98ybWV6fhakzqp0059cHKUQWVUqvgPswubuBCz94H
	LzZt9Dt/2YnPhhaKWYMMkq8b0=
X-Received: by 2002:a05:600c:1912:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-48379ba54aemr100058875e9.16.1771184091750;
        Sun, 15 Feb 2026 11:34:51 -0800 (PST)
Received: from pc ([196.235.191.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a2392bsm123594785e9.6.2026.02.15.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 11:34:51 -0800 (PST)
Date: Sun, 15 Feb 2026 20:34:48 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: fix use-after-free in
 viio_trigger_alloc()
Message-ID: <aZIf2MJ6M3bGRn9W@pc>
References: <20260204203414.89333-1-salah.triki@gmail.com>
 <20260207153546.74d4fc2b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207153546.74d4fc2b@jic23-huawei>

Hi Jonathan,

You're right, the explanation was too wordy. I'll send a v3 focusing on the
fact that using put_device() follows the standard design pattern and avoids
duplicating the cleanup logic already present in the release callback.
I will also remove the Fixes tag as this is more of a robustness 
improvement than a critical bug fix.

Best regards,

Salah
