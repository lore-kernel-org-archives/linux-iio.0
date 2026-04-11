Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFD2DE6F8
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894982; cv=none; b=Rud6kbtdAK7W2FJDnAZd+YBwPivV5BUoh0xeSNJ2sjg1pNuMBBH83gAzDdxYYzUpVCaShf9LapUGU7x9ID6Sb2szwy1H+LwSbyRUdcT/3ISb6FGY9NSIHFNgLkRuEZNLtiHFtfVl/tgVTNpPcd7yUDz+AgRAfjLSFgju14pBn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894982; c=relaxed/simple;
	bh=X/Owopqa2S1NblxKaMHeWMjoYbUWyW8GVNCG4NVsplc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbs4d3vigICRDbzJpVX06UmAMuTRJdHh1N2oOSoIs5m7nOo4NTcoHDzYrFw4aGcb4paWwL81a2VwfqzkVGRbrhjOMWH3EjEY8FwDOzOh4K79mm2MqeAZqWl6OfZD2bEwUMO3nLktjjRRKR/s7EJ0S9dOyY1u+3zVXB2KuVNOxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTTiBGHD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTTiBGHD"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so1835251f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775894980; x=1776499780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCIDCtXAFs9RD/uw9KJW8YhWAfzATP1tiaaPG8i8cv8=;
        b=KTTiBGHDSQAK3YfNRFOchCglZ+ugIGmKptS/c72nYAzDQnryoWkaBX9Ke/q6vDsaRd
         kWCsc6CXc7/yMMn2d1nKmHfKfyHuVEh4fKBrmbh3JEaswwNsisNGMLYNFPQGfT1iuaFh
         AyW8mdqeadxgMUzSQOpsyLEPOgpc+AsVHfGs6WPcsvh9t0L/StqQih+A45jNcwi3tA7c
         DXrkmjsAHE1/EAt321kKYQVBHxVLtdPCwLbvN1HjXfJ6owRQKQt49fQHhhEBSoIT/hSp
         co6VfktCyNAdAlLgQIpjZA1V0MbE5fewK0PSbR7nSIUOnMVBPD65fLKKqaystyCkczBx
         ECrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775894980; x=1776499780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCIDCtXAFs9RD/uw9KJW8YhWAfzATP1tiaaPG8i8cv8=;
        b=XCNl/yt7M+KsdfmmpZiijR+NEjnF8SMqNucKJtZlyS/YTXU54hiWMEPtOHicYBZb61
         cdXqXBmb8pyr39ca6HPDykLuqK1p4SPNNO3N0WkhZ0HB4rSR+MesTJi6WNdXMTvkHYgI
         bR1NY4pc/+3XIBnknye3vHaQ5v0ipoA4LfDCZfim4izZcnp8M8+mAy2whR8I5hh6DV3r
         gRXqLUOWwDVeGkYwqPYdDOxiAR553/UNoN3UMe1e+T0Oli8FibVdTF+as9kVCQJYzImA
         zjQtjjqv5/XoYsPpXOPDM8mQoWKsvx4QFEXJIvZl4CP2kazMT+1jtvY3uuBVyP8LlUSq
         zPGg==
X-Forwarded-Encrypted: i=1; AJvYcCXT+zAebDFVwzyfBALxHwiJQO63wh2Snvv5ytFvMGxBC+3ZEpZSN8NUaIwEHvYSZBhHvlh3W8nWw7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ojD5KVE8HOiKwjqGAbe9aHnbG7H8Uy2bn4Qvu39iLgRNlO16
	TQiSENOl+8FhhGXe7OS0a728L1RiEFopgbKjiUv1b1O6WGDwoqoFLWsw
X-Gm-Gg: AeBDies5VWtJIQu7SOSFJRoyp/u1d30AMirdLUqICI1hS5ZHGSPuVqWFFbYM+CrbD+o
	bwh7lQdE5wBohMHFsJYNpcu7TQ31qovcSDbw/vj3QGN0aOXd29GuD1/fIjVxGq8xgqWEOgwOP51
	lwXrsnuDNCYC/GT7rXJ/bsjwoQQJ8MmM4WJxkNg401bsO6lzv1dWIqiPlms00t7ObujNNOHlAcR
	dFKegAC7WYBG+qHiTKpKIiHjkSwemKNPrfem5Z5XW6ciiyzCrvXo+43zMUsd4wlub24WPQqcimG
	TaKAkUsddzaTFP7t237IyMvqjNyWtu6Uc0JeN3JaZHcdJEwsXXYr/dPQZ+D1JC1knijDQK2S/Qu
	dlwqQizmVRwsuyKxPqK7XmJFUWN2K8Sokdpt+xec2dUw/lAI+KJAJO6IKfzTuZMkHaFWKJyZuud
	CzhqBsLHrVV1e1RPvUUao=
X-Received: by 2002:a5d:5d83:0:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-43d642702afmr8462151f8f.11.1775894979808;
        Sat, 11 Apr 2026 01:09:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm15002555f8f.27.2026.04.11.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:09:39 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:09:35 +0300
From: Dan Carpenter <error27@gmail.com>
To: Advaith Neelacantan <advaith.neelacantan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832:  use guard(mutex) for
 locking
Message-ID: <adoBvxrqMS1EDim2@stanley.mountain>
References: <20260411072503.106621-2-advaith.neelacantan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411072503.106621-2-advaith.neelacantan@gmail.com>

On Sat, Apr 11, 2026 at 12:55:04PM +0530, Advaith Neelacantan wrote:
> Replace mutex lock/unlock pairs with
> 
> guard(mutex) for automatic scope-based locking.
> 
> Simplifies code by removing need to manually unlock.
> 
> Signed-off-by: Advaith Neelacantan <advaith.neelacantan@gmail.com>

The original code works fine.

We're not accepting this sort of patch for old code unless it fixes
a bug.

regards,
dan carpenter

