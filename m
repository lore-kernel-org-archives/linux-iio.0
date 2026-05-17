Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6A3C6A2B
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040601; cv=none; b=e3PKWUgrnbtr1y36vCc1zw9JxJ3t5OU59axbWnSDYxfaDl0ecdw/k/IJPqsHIR+NhG0KZbIbL6QqQyJ/w4pLYXkiKBcDAsTbreD1n2JrgfnLd14npYvDylnR3Iy6jYIq9JduH8uzcpDIQPAe0OVZRewm23mrW5zFzUgyiW1nWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040601; c=relaxed/simple;
	bh=y4u2xMKuFPGkHbz/kg+w/kclRoFx6dy2k+NOP1iG37w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+0tY4rqBmh33OMjlYt9C75kEAmRohncrQ6ilhGATU/kF3rCCbLRPyVd26KVHSDQRSmVRYOcdhgwr5RNKXA6WozIv+zdrQEUN56P7tzb9OyftjIIvrGXY90No/0+2H/hYjFbOAh51Av7qkebJCRmYY0hsGSndtbn3ECj+MKkz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eldXHicr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eldXHicr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso2078015e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779040599; x=1779645399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4u2xMKuFPGkHbz/kg+w/kclRoFx6dy2k+NOP1iG37w=;
        b=eldXHicr6hqNBPlRr1e/VfexCPm5Emap32degMpyzLEBtosuwstWHBWQMaMe9DLXKR
         iD+Y6B+UO0vYKFm8WZAyKCc+YuH7d/FwO6xa/sIQ1AAWrauWTF3q/90yk140zprVuc1q
         nj7RI4deNfgUryP9lGiDCl/QNV1/QzRdTOo4yXY0M3L0rwNLfONTXZP9PHyDd1C18jLK
         Z7t7MPtzcNvq2unBKXHJWYjU7zr3OhcQXOhnyH6C7zTFfaPuhMwsZP+DqIRVmI0CGrVI
         2WQa8SedF4Ikt8/djUrTCgwZvuX3Nhn5wip6rKrMFrQTjFrk+3MBs16E4tEJ8x3j7eiJ
         WyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779040599; x=1779645399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4u2xMKuFPGkHbz/kg+w/kclRoFx6dy2k+NOP1iG37w=;
        b=nPTbzdmiMOJjIFSAFyMex6vReuIU85GvuHhMvSdDg8VaGUtYGm5FWVtwtby8smLnoA
         4zrNsuG1WGIv0KL9G3AR4izQa0bvgdewqe4q3dL88KPf654ClfWc0zvQxUUaN7afLwfC
         2pgutKZQHnAnUNXj4Jr2Im5EKtYbidj20EC2Qb/+kEQliaGgD8mcZwBMplo3xh91KoSX
         azABs/vQ/rBym6YlhbHgG04MU/E/ufGc0f16eOzn9eurYWW1E890WUWdmTFm3wlytmtw
         NRG9u/ZaT78GgOFmA4mrD2LESdzJh7gWVwaMEJ53SX1vc1AXzJUC1wF4vC97/qRvSpVA
         nkrg==
X-Forwarded-Encrypted: i=1; AFNElJ9VZydxhlBmqyzRyVPpHhKupYiIdEMG64IZcX3LI+tXTlyuZwe9qb4oMPc2AfvC78eMjOO7qxV/E7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO32q/45z15t8EgB0sz6UdmrqnIZVZKAwynf1KgdNTkrAYqLvy
	ZbVuaEjTZWXrL+evx1uoRkadaugTdKtJAaSZAGSmZSxomek1dMp4SS8/H5hb6QPX
X-Gm-Gg: Acq92OFf0eYarWEt6szAZWoSxzLVFnICM6t9tVEgnvm+IRp5TAuZtNOC8RctZgrheqT
	y0cWE8TBwHtY+k9rxBB5BYp4kXvPsBbRn3Dyj6LLDhX8k+O/FjyjEncyAf6uohv8TbVi9GC57Cl
	2h3oITBWcg69uCEzUpB/eQz9zFGsb4sAh+QL3tgbjoRrjUKKiXFZcKAl9cs7KzsAwWEbmt7QQ8K
	EcKpk5pzomLxuNpGkJ3Du6cW0L1aGhAKsl4xbYf4yik883A9DMcl6DXImraCzDmz3X5ucT8WjU/
	Ru0qpeIQ1gBMUd8Tc5T5hMFyQsNbp8Y7w7TAjaPWhTf/L3IGAtv93l2CYaxg8PGKBsxVj/KEQe/
	stbuEllVU6JREO7Usqa5kVj6n6SGESvCbAxbOC2paBsFLAluTofqqBOy8YU2Ht1lIDEGaudb3V9
	1F1Fti8CCV92gFt/Ocnxnr/7RnzwtkZ63pe5ovJBw+bQKM
X-Received: by 2002:a05:600c:4fc5:b0:48e:65f3:a950 with SMTP id 5b1f17b1804b1-48fe5fd55cfmr85819885e9.1.1779040598450;
        Sun, 17 May 2026 10:56:38 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm34088259f8f.13.2026.05.17.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:56:37 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: dlechner@baylibre.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH 2/2] docs: iio: triggered-buffers: use new helpers in example
Date: Sun, 17 May 2026 22:56:24 +0500
Message-Id: <20260517175624.1345-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517-iio-doc-triggered-buffer-update-helpers-v1-2-7f00d4188f6f@baylibre.com>
References: <20260517-iio-doc-triggered-buffer-update-helpers-v1-2-7f00d4188f6f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, May 17, 2026, David Lechner wrote:
> Update the "typical" triggered buffer example to use various new helpers
> that have been added in the last year or so. This reflects current
> expectations of how similar code should be written.

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
