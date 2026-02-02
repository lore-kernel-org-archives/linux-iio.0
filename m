Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27F313E1A
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073801; cv=none; b=dBXuxKYMe6dcDL1oAtH8+OoDPb0O4+c9YaXybjUWVq/s2YSezOs3RQ3JoouvGiOnmPCQMbkVjwu8BHf2s+QqdM4vgqI+0uGknUJFMTCFTqFFEgmUna2SDQVOagSqP25tn3+g0Rc1SAN/kth4KrGJU4i6ApCiXdAf8P9ApDZf3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073801; c=relaxed/simple;
	bh=5OwP7q4JflPXr1BxsMJT6j9uWfDTSyk/w2tuUQEZiBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW1JiHX33NgniX8x6cDVxD4QCjtp7qHonNnkfNsgri/vW4CampDgOvUgWYGD0bdlrOFoaYT2xIR1Qpje81ToYiXKAAONyObzadl+xNxLm5l+DrKNQadAo4GXaYz9Bn+T9Aw/BuTUYnM0SH8JnVElByDVL6AFXeKS3HSFHSxgVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WDbKpL6R; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WDbKpL6R"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45f0dbe7dafso1903636b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 15:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770073797; x=1770678597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTPsyWXhp7gQeVnDTqTm1vjlVom157BoSWwibsPzNJQ=;
        b=WDbKpL6RhMiQXem/sIvc5FhLzWF2nmBxVtNyQ1W9SVPCbtUL6VGUtytJel/wN+9GzK
         ufYEvBqWOpcNkwO2RhqsPItiW9dpj2FBAsLFSNYhb5w4hAJagv5UiIr4e8t/SiwgRFoK
         MH27RwRFYOjiPF9mOXU1xc7VyEUIFTfpdtLK1sJ3PRPkiJAe2uZNepoYLIiKdwq2JwaS
         nXChOUwElKgL8bEKE9v0IaORNI8uH8plTiXKVQnaPWtFB9paKye3jiBjMwZjFfYzTHVr
         4vqYKC41LQ8PbH6FPN/bfyxAZ3CghRhkF4eXcDjB5YKZbl2oMzAoxURAhNMgfgXHmbOx
         z9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073797; x=1770678597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTPsyWXhp7gQeVnDTqTm1vjlVom157BoSWwibsPzNJQ=;
        b=IbNykdvQSRoiJ8Cmcf96bRp2cTf/Qyg5JE8lWohd7dDExOJFViuyWhDEsYaKAo1ERQ
         GY2GXv2Jvkd0tNqRoKRS7TLy9TLvxrjeRev4gkd4QDRhSnEaqbu8ieGEsyXGKB6+24mN
         LHMvHkM2A69lzqVStsMawEBCnD8J/lUONZA2tvnA0SMi5ys0Dl2I9c+DrJPyKlTOnZ9W
         hJe4kIWPNLLj2/74rzOZRtFAsWDzX39R5N5iSDn0kXDNbXzDaso7hkL7J30//rSiS2We
         BS15xmyAvdp1QluAzrAXcV7dNI65peMUGniHYZHLBXchR2om9PrfquNJ6k2hYhvSLPsN
         mYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCViT+9ycNRjj17bpYk/CaOjUoY8O/GMakzJh3RFoSk+Hxv0Q6GczubDxuHAubg1QZ6PJn1J5bVnVUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfb0oM+VZXUdTn8jtn1FRPHYqEHee4DjcokArz6cGDpmzcY9uM
	ZxjIAwArP/5rY2JCB4Uiil+FPQN7XbwKQYlI29AAP8GV3bKgBF0RbCQxCv3vNuc5nRI=
X-Gm-Gg: AZuq6aLTyeIbxmJWNXwi/EJ4bhX4X9zZFXvXby1S3CmT648lHd0CbWqvZqBWhenAdjz
	jPwjnM7izTOyTaO8qr/mOKQpxZlNZLXFDiSHPEEBOpX1m34FFlalK0H1uE6ZdeCMDp3v1VGEqZl
	YKtbWf++clgzfc6oWSPVeK3ZHwjmlkd83UcjI1jIvRXg/W+buqhuPEjG7IVTmtLGGDdmpPdFub2
	O8kvFUkmjMh1WM6kr5ym260Yd9iAfqpPgCvl3J+hu26L7AH9R9zEX6HIcyRn+dlng5+m+BNc8Ux
	au9lRke/I4N2bF7E9Q8pqsGCYxeaHEmMtDYaSHs05bYaEcDA+j48eWKPYEmr+nDEP30eYfSRo8m
	q6UbWBLGHjDyn6Mv9p8QsntRE3Wxb+TK3cJEuhgi6nt0XEomKbRkUDTvIpZAIcawaLd+3q7hC/R
	mMtg5miBrYFIn55XvlGQmUUA4wdw5l398QeASFarKfVx2o99CIVaflxtDXojyj
X-Received: by 2002:a05:6808:11c9:b0:450:44b9:68e0 with SMTP id 5614622812f47-45f34b12ef3mr6948473b6e.11.1770073797185;
        Mon, 02 Feb 2026 15:09:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08e23c09sm10292692b6e.9.2026.02.02.15.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 15:09:56 -0800 (PST)
Message-ID: <737546d0-31ea-4d24-b097-f869451d1146@baylibre.com>
Date: Mon, 2 Feb 2026 17:09:54 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 5/5] iio: sca3000: use guard(mutex) to simplify
 return paths
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Gustavo Bastos <gustavobastos@usp.br>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
 andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-6-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202194033.627967-6-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
> Switch sca3000_stop_all_interrupts() to use guard(mutex).

Should always say why this patch should be considered in the commit
message. E.g. in this one we simplify the code by avoiding a goto.

> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibe.com>
