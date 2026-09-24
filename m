Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6647605C
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249385; cv=none; b=Tc05nC21L2oZtB1B8T0fdK5mVBHN9Te+9adZeB0q+8kIJSLXcI/sbqctJISJMzmQEdGTv2FqVYV+VDrVrKUsMNAZxTSAz+AEY8SrI2Kot5fybzOXQDtHeq86hFvzWHtz0iua/N3lpV+G1ONGGamdoLOgMDkPkZg9m/wnTDB6yQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249385; c=relaxed/simple;
	bh=gTmFQ0oJHViRUsuavsr8vMA6jtJ+ccLcnGzXGc56JO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XC+4klQLae+K9Li5uvlpch4JIxyqm4842p9Cxrcu/BF+p0Xu3lT4E8A39ITN/4oUVhVXZwkRK/rRbdPpj9+o1/BaWVzwmB3Aeawc7D9xCzjgR1clG6rllYomSzYycDd8rOrcijCTIi+LXZdgYZOWgJm92SYi5NjMMFwjZtvhQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkjPxkEw; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkjPxkEw"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso14140805e9.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790249378; x=1790854178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqJYCgUdmptAxAUCkfCgkXC7Nfbl/0yHiSBbVHAR1aQ=;
        b=qkjPxkEwyiuRN8b/f/eLfstErSRzqdsogBAfcRPOQRlUfGcO+lK8sjzU3vumZ3jRkJ
         qfYd2yeCl0+XyU0Lu1hWT/WE1YuZ50mSlArHJx1x7PBvZF/828a968Ee1jwvexwvfhfQ
         pnzdPxgMeL1TkDVv6jhFQTDhlzAVDuVWYQEivjqBJ/J+Bvef6WnZnsAf4zi/FUa7qgKx
         HVDxADs0Kb6CkPy/cz3OzCz3Rwk5wYjLt3BOrsL8ZOw7O6B1I+fRM+cRoV1WQzt0Vrwn
         DSvlRexguH2ODHucUJ6l+82jW/b+ECWKHJfC1H3iCxRSE3in1pt3zezmtEF+JjePbr9j
         gong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249378; x=1790854178;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqJYCgUdmptAxAUCkfCgkXC7Nfbl/0yHiSBbVHAR1aQ=;
        b=0B7NQ7vvo/7vuaGwqn4SS7boHNpraHQ741MT4TLIbkyO5GXnBLjJ8uQgAF12nrB1QK
         X0VB2J35AgkUbnDVsR8PbJBruthB2imRd0WSVMJVD8xWv3NycRqseugIZp9H+S+gTt38
         +OT3r8aZu9Uqn3st2wtOjVEdUw6XN5iL9i3HJk/Z73yJgTy1DEKj31umsG6q0vV8HeYX
         0vfPomNeKs5yIs5tzuCNlXXxBwV4C/nDyY7nPqcxxcxZcYYWFyZGltVDKx9lp4ZXM5sv
         OQaBpYnJvEdyT4XVJXNu2+rh5roPkl23ZWs+mIevlaOf+a7z633zc4Wc0jm2EvQqmkVO
         rrRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFl6F7sq44Ad9BnjUTxtmX0OL5yDuyECQVF4QE8ADcNEcw7vtGwe4MUsqiU+/awG8Jg94pR4oOGdI=@vger.kernel.org
X-Gm-Message-State: AFuF++kfixb7KClXNKtTJ7j69ljkeuvBAGJo8xs1sLGUT88Qg1fXvlSr
	LvPOlqqVB3jGIp++34FNuPqt6KYIa9dOq222gggUwlNAegfgALq6Fftm
X-Gm-Gg: AYBFou0AbMAOOlullsiRsJB1uJwgP7KC7Q3Wb/4ugifvEeP0OY036vFWr1CpQHK4vVv
	zFrVUkNWcU/6O/gkrAuR6ODbeLj3y+TOpH40lgLMZoARdSVlVyiLt6ymxDwIzgQ3X4UfrA5zb2O
	UUYaCARPHxOgPMcXuX+oB7+II9MsmW0im8TTjorOz4j2sEZGVSeCdA+5lNWCG0bwoSHeIInxodH
	hDRbRmzMd5uTpFHyMmEc6RDhZwtG/mlT2nQX6/wTWPEBO/pVlY4w7HAs1W1AO0iVT2bMvJtJ9An
	raH4i45fbHGqwlnym8LRjD/CIl4CHm2NTLJtRZ3TkwJSg4AYfSAWQduiMWEhgd4rO/x4ArU1VRe
	so3WIjcA7kEgIKIXjUUQ8uFWbGJ2TYe2fNxdqZrmqCTURw5LC5ClAsKEPWXSdAjtv56ql7EZJoj
	Of66jUx9HkpFzZATWUAZM3vQ4mXgyBBLrHJVBmqSguW2/ZnJ3cSbh5AenVmfcuSmk/p4AYSGOtQ
	E1Bg3KGvrTy5Q1j2vElRMW5s8kv0v4mxRutPL/sqatio2KNcvKPViL2CTtvVqC8p8LydVkIMI8+
	jourZKsiEiN72MblDhCUGeebmOlRLhbQHq7KaTO3LiKQXNJ6+kh7w2D0l4t31IdZp0N7uN5EA1X
	pUsbT8a/LfqpCmKyGRHRs9aIjwHt8kkI8+5LQTdrYwv/IHVL9rbaNu946BRwLRkxVr4m8Z7oAgJ
	2yT7UxqmPgP7ALzuE=
X-Received: by 2002:a05:600c:1d29:b0:49d:797:83bf with SMTP id 5b1f17b1804b1-49fe66f3c7cmr39286615e9.21.1790249377765;
        Thu, 24 Sep 2026 04:29:37 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm59630995e9.6.2026.09.24.04.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:29:36 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:29:35 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ens160: use regmap_assign_bits() for
 conditional set/clear
Message-ID: <20260924132935.00006ed1@gmail.com>
In-Reply-To: <20260924083527.461864-1-peng.fan@oss.nxp.com>
References: <20260924083527.461864-1-peng.fan@oss.nxp.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 16:35:26 +0800
"Peng Fan (OSS)" <peng.fan@oss.nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
> the simpler regmap_assign_bits() call.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
