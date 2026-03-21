Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8438B152
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094199; cv=none; b=uGromo8zkgqUiUHzk6h9XKdoJxwwDIC4XpW+Y3CgGSQSEBmI5Nlp3sDX1gH+bAOj1CZ6ho1w4nwVSa3HavSFA7gAPXrMVu3UZqsdOO/TS07QhLZ5xt2lMQclxsJvyaNGusN0hWOp26VYwl2kQ1i1TaE7hmnlJsFt36hnVTxY10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094199; c=relaxed/simple;
	bh=3hz09FXjKqeA0FYN/lLJAOKNDNRmbeowEj8fk4c5DP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWfdUdewbXQciNduxLe0K0JG/lFWpx/gywM/ZWxdvD0YRNHvS9coqrNRlKMfIZwfiUEqc81WYXZ3OsQurnB/OFNG2fU1NKv0pqKx4qeo1Tq5YFdHj879QFaeoMXBc9DiGVLgCT0jvGfdgM4pWHexaqSeuL+/SsmZY9ZnmSlUXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRwBJl05; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRwBJl05"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso575516a12.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774094198; x=1774698998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyPUSHf/lFUBVfcr7o+CvlcxzD2V0j+793MDps2d5uY=;
        b=dRwBJl05EypXdMeCGC9m6A+M5mDjIhNSp2nKaZIkbQ5nUHkcEu48ULfT4CoI5+uu85
         2e7wEgs/sCiby21y6y/LVTYN9N+YQ2ngDARMpKFfyTxgR4n85WMQRoJ3BylorMo9RVX3
         UxsUFWUBbyRVyLJ2VFV9KXI5uiILwvyfvkZZk+Wb7ABvgPRdEBOS6jGuCi2KnsGb2aGk
         BKWmU0JLz6sbPA0yej+Z9Ptzh3oUONNndvOjSu2OXnUyM/B/qyQuv9S3VaKBj5qxHubi
         E7cveJBTMabs+mGhk0YXwUtbRRaEwH4DMsiGtaJ1rV0QWR+E6iYU4R16eTFK3cTh17/B
         iXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774094198; x=1774698998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyPUSHf/lFUBVfcr7o+CvlcxzD2V0j+793MDps2d5uY=;
        b=en6QsrDsfIiqFHVIqrWgSUCMbsaFTYQ/fiTTu7usqe6rcXGB7KcxF37wqba26Qqnsh
         flq11NAL1Yu9B3iaViAsr/gcImi3C77u8qNLJLpUxyVqouxhvVa8aGYQ013muDfsvAUz
         SKTDrR6XHoaLTOPsEhhhzaIpF5dQCJTTtu6WmxP6xVI07bAtNN7e3yRZlzfqHKOa1bbC
         PVooAuip58kcK/8zi8nQVZELu8LCs2XWpDl3r8nd1LUgBEEFD5bQIp9Dc9CycPmWarmu
         nSS/xCpW9jtKtDntxwWPDkpIw5bBvOtVhjR/S7mz3FcYfiPQ4ljtPI6zHB0z2N+ODsJ/
         mj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlwCQ6tar9HYy0cGgHgRka3V/6VIptpRTG/Ifez/yoDC5NTq+Be7jobZXP1MuLh48T/wESWvC9BD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdbya2HnsPFp+kjgRJJ3+8UmhBXU1/zng1uifMD5/BSvIbdC2
	34m5GU9URe1nNRyOxQ5Y54HXp1SnhQ7zUQ3M9/QPVv2fJvtOulczjVkO0bQUrw==
X-Gm-Gg: ATEYQzx+y9n/Sb19w1fyKekjdZFqG50iImovbgJ3Gxn90315+5f068TWQLtU7EUYy8W
	+Xyc04l6ZyPfJMwTvDcTysxFkf2aWGXNMKZAmqAcTRCmmRS9GtrCnJYRzXqFzdRkMP/Kk9+lM3L
	ip8kvR9PKw9WPnbo1pjuufzLlYHnUEqAedWods65Duk2a8MZEuLVfjzlGkGYL0mwHgy+Ss2lpUx
	j8LVA+S5noutXJ31ef/ZmtadAfBdSWXmiaOd/AhneFPMj8FiVCMjzc/5BrQNrKMr9zn68f7NcA5
	QAjbGKO1xxPCl8pxapR8VXjc1Ac5yqDFvW8CJ4I1BGOjTRmSd8BhArydkSf+O2Ps/HYzannvXD8
	e7sekdWbrbsJcNBAcINJnY4aG5ohtiibvx15Dn+q8Htu0fcM1a6nZvwC/Jpkvr5APmOm0C7f3Oh
	WcEAvM9B01npsShD55+Sc=
X-Received: by 2002:a17:902:e752:b0:2ae:bf32:20c8 with SMTP id d9443c01a7336-2b0827a76c1mr54923395ad.31.1774094197648;
        Sat, 21 Mar 2026 04:56:37 -0700 (PDT)
Received: from fedora ([122.173.30.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836554a1sm49557905ad.53.2026.03.21.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 04:56:37 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:25:42 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, i.shihao.999@gmail.com
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
Message-ID: <ab6HPnoJZLocFIMW@fedora>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-9-i.shihao.999@gmail.com>
 <abgt1yoYTnQEiAlk@ashevche-desk.local>
 <abguXZJjIXMdqcU5@ashevche-desk.local>
 <abqsaI6-hznIv7dO@fedora>
 <abq7g-9GnQaFc_1K@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abq7g-9GnQaFc_1K@ashevche-desk.local>

Hey everyone,

    Just checking again, is this patch series  rejected?
    Do i need to send it again? 

Best regards
Shihao
