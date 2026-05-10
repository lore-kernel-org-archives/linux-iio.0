Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A527B353
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778405506; cv=pass; b=WPintR+P/CVWoXtnrzMXv8r6TMz5IRSgR1gRFgMgyMgfxljiLa/HjUofHb8WNsmFuyU3NCBuvw8LAx+wb5IYr34gyEQsaYym/e1kFvp8d9jkcokmjLN46Z4IxEWHRjpI+6CNpXAiqN8UrbDM2Hj+am0LZzdbsqYskrKvOrbPT1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778405506; c=relaxed/simple;
	bh=oe3xfWtcC2xxpq5nAlWBl7hbI4M5+HYKZ0lkzcRhyXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJf43Q576+30RO4fHX5aOJiZE8Qdb7ERc9IMJ/QFf9RNSo9yTNe66odORxDBidCFWvx9dQI07+W2WVCFqoacJ/PHEp7MILJtLuyKJg35wE/XxqmHQj5jM641/givC+JEOvnMqkqtNcflI+hvphudfQb0Tc5KXf0Mtys0iauCICE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD1fiILl; arc=pass smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD1fiILl"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so3578844e87.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778405503; cv=none;
        d=google.com; s=arc-20240605;
        b=c50BdIS4slidm2buUXv5ibaAzijJp+x9HQePtE4PUk1tXv4x03uiaGLYtyThvr+gSb
         pme0I9hanlgrF62ryqWqfLCrHX+uMQ5QO3uQha4xGuMspcwCf/2FxRj72MPty4IkBWIl
         Wgi//NjEUEvhq9qmHL4iCFX15xFqvlB0CCJOdBFAK6l82GlkFSRmMQnIxjFGxvFZxcac
         zQdg9xgYSAcDeHWTTpw6IJMmtzMvnZSJFhUhfJ04R+XGNXB2L1LO/ybX5gQSBhRa1XKv
         Z2nwKAltWbIzLuWOjACItLV9jjQOy6giJQOwYPto/6pfRyHt5nQA3WLnPoNpydRKxVNm
         LprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oe3xfWtcC2xxpq5nAlWBl7hbI4M5+HYKZ0lkzcRhyXU=;
        fh=RJLogbM2x4P5BghhMwGEctD6VBqSB9RLBDvmBZxxkS8=;
        b=UXvCy/C4N7WckhcdfbNwNZZNVdyZA6o5Jl40ePyuHeQ5HBx8ahitVcG8k/z9BPjB0r
         icvnFc5IcjJCknYcuZG4n/sXT7Cw/2zxyRcwg/6zy3G8Tqb886x8pAdWV9+014ERhPmV
         itmiS6iUMo6Esogr0KQb9Fl1vLkl6OM+h0WQSKSlXicfyM9zMW9cBMd/QF06KmqzkTQF
         NqBwqjp/XZRyWwKuftu5UHr3U+7Q0A6l7cOp0MacDaZYdibC83lxlgtYvXGKt6nx4SET
         3HI/kBLjndXNcHjSPrxo8yZ34+wSxeirXSma662yQ9UTuOXuZ6PaCjyega5KhV5zXRmJ
         xbBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778405503; x=1779010303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oe3xfWtcC2xxpq5nAlWBl7hbI4M5+HYKZ0lkzcRhyXU=;
        b=OD1fiILlSFwHYSXW088E9mEYhydNJCupAyEVv3K8ifRE3wB8VIOodnxTQRhqffUhni
         W5sZ4nfwtW9ETZ8vw1apsk2szL95zVgqyKTlo5N8t4ID8XZR4nevDPkL7FP/um0O8hcO
         d72MvSLJed3+PEpWbYgtqG6QJugZ8UPtJveVH9iQq86nqxdEsznuNzmuwtIGcWkmUjwr
         aWUqFSOSaqPaNbbmGoq1xJSLGUAyyYpSk05CCpYQY4dED1B5jWc8rLfLe/RgfFPwkP0f
         P+9/5xoci+tfhk9LD23OBb3qQ9Ih1NHqt9g4G3upbpBnyeNOI8DvCh4HWi+2WC7rY2D+
         5hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778405503; x=1779010303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe3xfWtcC2xxpq5nAlWBl7hbI4M5+HYKZ0lkzcRhyXU=;
        b=djV7nlyVvx75SJYg0XjuHVDEjoTaM1uToQ49ypBjqpPDLmtZLd0syRjHFdOIhzMAgR
         XWw342X//URvynmV6HLJKi4qgPUis35OnnPAtC/FH+ziFor/uMCAM5y/3Zt45Fjlu14A
         +6nNNZ4+vaIt7lIiKoeIQZT7oPjHcVN4BotfLbuFaqdeyg77qTcWv6E9nLor4zKgkBO8
         X0aOXNAj0MX46Dd9/zEzbJMNWjyRDxiOGfuzNO1ZyRWtad/8G/B7Xk/GfZTKOSO7Oe/0
         naKRtEnqFdb8KCfkldaic9ZnHIGN2YTiIjhi06W+8QmXYgP9TWLhvZly623+NPEJsBg0
         q39A==
X-Forwarded-Encrypted: i=1; AFNElJ8M9W65kABNkGdeA2ICUb1QBb9J1NNt6LQRakmVUsqdTtVeUzH6lf46Ve4sBeRdvMH3wbHbFjSF6kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOmvmMxGAK2qg9p7VrkXLOPoUdaR8ZMl66oHcyyJzmIYfHj7X
	BPU9v9+kM5WQKb/n/8xFxIYRn7pxd3Okuxbdx1SnjfQGmgiJwbA7K0h9FoCP0siRrM7yHDZKm+k
	WQiq987XZEVpZzg1znALnriMgH1arcZ4=
X-Gm-Gg: Acq92OElZl7MdxAHMpFHkJ4xem7HxuDis7eG26l1rrZFNtjAPAknu8o/nRvX2DdN8wH
	efx7lWS5iy7pt1ylCvgyR+yW1MxiAJyBR7cGvxYMfsVUNWLhOVb95UUYU5QS7qV4bzuEq7xM8Wj
	gPAPmOQP5h5hXjxaA+gvvKFQelOJehUY4u/ZMuKVdBpxs6gcxE0j7lTyjl632QaVlaEZWDMXVP3
	KYnz0BuF0PBHmUV+F8zxqZcjaG1luCZLH3iO7xlKaz3pc71ywckgVjINtvXiaMJTIr0LBV44IxL
	lYiqLDYobqODva/nFd7RDhLQVRWroalBKGprmVxivL9M/dSsUd1q
X-Received: by 2002:a05:6512:2256:b0:5a8:5699:6d3e with SMTP id
 2adb3069b0e04-5a8b6ca1d89mr1418016e87.14.1778405502894; Sun, 10 May 2026
 02:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510081041.85880-1-dennylin0707@gmail.com>
 <agBH9QqHW-cJN0iQ@ashevche-desk.local> <CAGEkeHf_wueMkwqQmQ0m2drXQ_m9UsvcFwqu5RVvg0WsjAJW1w@mail.gmail.com>
 <agBPR9xke1MTzL0B@ashevche-desk.local>
In-Reply-To: <agBPR9xke1MTzL0B@ashevche-desk.local>
From: Denny Lin <dennylin0707@gmail.com>
Date: Sun, 10 May 2026 02:31:31 -0700
X-Gm-Features: AVHnY4Jee5Cy46dbTQS-2fRN4iAVwne3JIJc6Gnis5eUGpR6E-Rl3RAwfbr1f7w
Message-ID: <CAGEkeHdZoDGtHS0Cmh-HULo_vz44gF1sDMoxrtJ0Ykf9mqcZ=A@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: document SPI interface
 switching sequence
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do you have the Datasheet version? Maybe URL?

The datasheet I am referring to is:
https://www.analog.com/en/products/adt7316.html

(ADT7316/ADT7317/ADT7318, Rev. B)

Thanks,
Hungyu
