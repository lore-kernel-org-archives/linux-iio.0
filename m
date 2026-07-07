Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF638D3EC
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414828; cv=none; b=o6T6N3quoUlpY14JK4rL78DrT8+UUsF1NjN2E/ynI8TCMSLByt9h7mEDvAeLbBzQj1Z13m+GSOJ1p+xkeHnar7p0ebApXbLuwKmYGHhTux9WinBKoe9JbaJ/HRZtNkD9eTLhFky+mXBTebqIM43OEzqHbH/NHDjXVaMM2Cfwd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414828; c=relaxed/simple;
	bh=Ptei9JoVVIB5GON+lwznGIQ1eYUaNiXHrC992FdBm7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF9K7EElIrRGYsrzM9WBdOp1dkRUnA4QpJHQZNJWrV3npbVLzHMF9aRZ7OwPXCdNwPeO5qFXYDWVU2JZ1BuoLURRC50+C/45Cc+8mou+NcS6yJ2jjJZI4HeahVQbHsSWLt85j/ic5UtPr8hw67haQNtBPI0JytQD46LiZ/H65pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk4oBKiT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk4oBKiT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493d3135f62so15250275e9.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783414826; x=1784019626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nkwcchEu9Ml4OmDJXkdrk/JL5BeVqN7tOXDSpcJEoU=;
        b=fk4oBKiTT7WND7oHClL8riQ8wBTiyB0XTW6TYcw2NUYImdtXXpx4xpvlkU8pPY2KWs
         1UBZALT/wIBM5qnyy1mv9146azNqFccW3kgwpxJL642W96FqXxi3lG0vSn5FUZ6GrxWO
         ICEakBmufeqwinEh4BqfSsqm1hpUtXKK8xYbkz5ovm9SlshjdlyTXzzhCV49SDHQh9Gu
         SV18LODCrFCWEGw9HXhzKaC1btYNXHjX1gG9UlnUknAaHSKzXn0Ka5OcWDgZjUebgWGw
         9vQTstDEM34z10zBrbZbBsTdlnTFoL9zh+UXpUzx/9lRRbvnK4cUpo+5s1SeCEPg9Ow/
         NRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414826; x=1784019626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nkwcchEu9Ml4OmDJXkdrk/JL5BeVqN7tOXDSpcJEoU=;
        b=eVWV+lzo+JhPoeOOeU4huP4WLKuMu4PQvH4ldYPmgpjNvRlWRN8XBNGzsRwc+yFS27
         S3/i0deFwlHorQASN4wv1uzAacvyTcvZuH7NmQEhVqyR1XtpVUCJFqTVhxL5/obpIn8b
         FEf6eS8H8FS/1nUeyTbLEamq2iYyaqM79FVFejF4YZPpl25WZ6Hv4ADjgNWif2eqaCq2
         ecxJRdO34OQARJwwwjFjMufAm437zin/E0zvioJ8HHVgNxgSd9RG5F0BVU5BPMbIjZiH
         nkOipnRWgbo8JwImbXW3XYlVRutRnqgjirybfaqlSYPXqjR4cfdKzE2PAXjdmJMuFWEX
         zNsQ==
X-Forwarded-Encrypted: i=1; AHgh+RodnGzYlq6MAcbBwOUP2uw8TyMg0cawZDqCrAYaIk0R1txuzgzV+/ZVwotJQvJadxlTPBKcsY/CBnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qdO5Xz+eeZZlZupPaxskn3Q1sbZuK1turmf8MFGBPjeJYgiy
	8iOyE0E29fmPM8YigD8T3D2bJY/x+jGn51jo/jMJ9IeO6dmV2laQraF7
X-Gm-Gg: AfdE7ck3/+GqHT2gmF4g7x8e2wnxDqrFrN3BrkyuS+XgMf2k8S8x77UJTNBHJ87yIEh
	BK8efP31Dz58eDSuIQ2MSsmyzuj22tdps0y4bgRqxPvq/JBqw7pQg/9kFm/tZfrTxULnk6EcEGr
	jj/E3h5CAGw3xpJCL6HOYa6WtuBZPebvw7RX9i6dNXZkDPyC5GcYPOBLpU4CqROJJJxFFfSy/+Y
	bTXqhK9m3UCT7xvFsPvh++U23iwNw716c7+RvUzboffTckVSWDbJKp839qxcNFsIQXLMAE/ITOB
	RDxen/MlTBZUegc+MuAxc539RjLR9JdLIuEoefqp3m6+cHf5F+1OqpKPUI0IOHVYeZLZFGFDNx8
	sz6BwzTrq9Im3gzStH3TTpg8SoX3Dqgj0tOs8LYXbHXeko0EpmJQVzrusaNXQIDyXwA/7SVYcc9
	OZeHF6yY/VtYv5rJv6leHR9d/JVyc2i5VQipOqoNRHHttdO5+hBtNs/k16pqWGoMuL6gFKnFE+l
	Cyiyg/bpmjJWC+eqPbmcU4enWWzmEFoyZVm1fmQ9/px4kC/YlaaH6eA2pfGwIXrBUNb1HNE5Uq/
	+PQbToD3jx09+1scHEcgXrZ7AnGsFWhfqyqoOAB/dcJAOSb0VmNoDn+sNr/9fWB/LtQgjJm0RJf
	bpidtlHwGZsN8MGLi6kHMuyo=
X-Received: by 2002:a05:600c:1395:b0:492:58d6:2565 with SMTP id 5b1f17b1804b1-493e0c325c2mr21882075e9.25.1783414825480;
        Tue, 07 Jul 2026 02:00:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f44b3bsm35617455e9.9.2026.07.07.02.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:00:25 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:00:23 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
Message-ID: <20260707110023.00005e60@gmail.com>
In-Reply-To: <20260707014525.1015-6-kimjinseob88@gmail.com>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
	<20260707014525.1015-6-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 10:45:25 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the Open Sensor Fusion serdev transport, driver core, and IIO
> registration path as one complete driver patch.
> 
> The driver enables the required vcc regulator, receives OSF frames over
> UART, registers IIO devices from capability reports, supports direct raw
> reads from the latest sample cache, and pushes buffered samples into
> software kfifo buffers.
> 
> Use final Kconfig and Makefile contents from the start, claim IIO buffer
> mode while pushing samples, and use zeroed scan storage with explicit
> timestamp alignment so the driver does not depend on IIO core
> bounce-buffer padding behavior.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  MAINTAINERS                               |   5 +
>  drivers/iio/Kconfig                       |   1 +
>  drivers/iio/Makefile                      |   1 +
>  drivers/iio/opensensorfusion/Kconfig      |  15 +
>  drivers/iio/opensensorfusion/Makefile     |   6 +
>  drivers/iio/opensensorfusion/osf_core.c   | 320 ++++++++++++++++++++++
>  drivers/iio/opensensorfusion/osf_core.h   |  70 +++++
>  drivers/iio/opensensorfusion/osf_iio.c    | 308 +++++++++++++++++++++
>  drivers/iio/opensensorfusion/osf_iio.h    |  22 ++
>  drivers/iio/opensensorfusion/osf_serdev.c | 114 ++++++++
>  10 files changed, 862 insertions(+)
>  create mode 100644 drivers/iio/opensensorfusion/Kconfig
>  create mode 100644 drivers/iio/opensensorfusion/Makefile
>  create mode 100644 drivers/iio/opensensorfusion/osf_core.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_core.h
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
>  create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d4199d9e..6ce18ad92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20016,7 +20016,12 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
>  F:	Documentation/iio/open-sensor-fusion.rst
> +F:	drivers/iio/opensensorfusion/Kconfig
> +F:	drivers/iio/opensensorfusion/Makefile
> +F:	drivers/iio/opensensorfusion/osf_core.*
> +F:	drivers/iio/opensensorfusion/osf_iio.*
>  F:	drivers/iio/opensensorfusion/osf_protocol.*
> +F:	drivers/iio/opensensorfusion/osf_serdev.c
>  F:	drivers/iio/opensensorfusion/osf_stream.*

Looking at the list of F: entries, wouldn't it be better to just
do `F:	drivers/iio/opensensorfusion/`?

-- 
Kind regards

CJD
