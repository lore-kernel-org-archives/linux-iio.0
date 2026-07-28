Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922E3BFE3B
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268677; cv=none; b=ozb6Y7JulQr7nhQ6t3n1sFMOgzUHXbNX7WjA0lK35nIftOTe1eX1epr+wVU1zbkx0UdTzSxPtva+rWt03VXBkic1QQWFUhoY9D0Pi1NktBkVaoufUbR5tRzlfj7T1SRDFC3UJzkgEtbCyGieIwTUYO8Nl5HbTA/3myluLQXIoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268677; c=relaxed/simple;
	bh=u6M2q94bjXLfw6t5tVlVh9uAocKnu9UhbvR5VxcQcmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQOXeac3KysDqYqLrLZQ94s4vgRCFyBJrOdfjASNdfTpBK8EY1mPAMihRdifjRBb8vqsziKVLl6vo/vCzL1aEaYFfeYr7DTPBqLmX3yi2ukXNErfRwVia34B9m51rys89JKAgQ4TadXDTSFzPAitNKBUiMmbWWCTP9IbjeIZ93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCX7gnT0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uDbRvxY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCX7gnT0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uDbRvxY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785268675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7qdjZztJ6qT9BfCiBdCLhwPaC/ieT0jM1NHA2yb34A=;
	b=TCX7gnT07eWbeeYvSXaYajV6Hph9J5V9QKdqOgojSVEHHV3qfRxr2Y/tTJmR/9E/2hRVvJ
	cbvy94HfiaxCm6/oe7ggdVTzLQa51p16nhuO1ls/HDA5TmFe+M1cHPtBpRdc/3/F7NcuC6
	FrrdTvUpj3AwBFbWoCBj1iF+sMVIlZQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-8V7mHVexOnu7ih2NyiWVrA-1; Tue, 28 Jul 2026 15:57:53 -0400
X-MC-Unique: 8V7mHVexOnu7ih2NyiWVrA-1
X-Mimecast-MFC-AGG-ID: 8V7mHVexOnu7ih2NyiWVrA_1785268673
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93106d8af18so29227685a.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785268673; x=1785873473; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+7qdjZztJ6qT9BfCiBdCLhwPaC/ieT0jM1NHA2yb34A=;
        b=uDbRvxY/17M61ggjnzej7xGet8kFk+s+ex6de5tePtiHWH7YelZyK3CgC3q7Z2n1jN
         9s23yQu6iIQIny6iBUDpCc7KG6OFis73HA7hzajOwTGW19hqe1pOnAKpYiS4zO+DKM9D
         SW0bzRSmhqnxzuMM3dcROiQgyIqTdWqsxkJkqTCmaNZ9DjSzMBA5ljZD0TPKJ2Ssdbyf
         p7ceTsQwqyjEGzRmI71NpIKHo21wWeD5i1eN84mEsv0b8fdYA2zmTdizeNXqYGD71Gda
         iktG18iPz4w/h14MYir6Nie68TPOQDR8uybiNPu7aVWlk2vWkSjeyFVp+H0YbDyHKS1E
         Y1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268673; x=1785873473;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7qdjZztJ6qT9BfCiBdCLhwPaC/ieT0jM1NHA2yb34A=;
        b=chen1Lbgmad5j7Io3DBEfmOmQrCl7mYb00eD0tVOnx7qKeGyumBts7I/K3+wMxqpJx
         yIM5ZUAPw6mTtfvYsNvLrc1hs13R/wdIdrc2TctNZFpjiiEB+3GCEuh0UDXTI3UDSRXy
         +xw5vOaJeC7kPZsh/gGkJFY5bAIIqVG9WzQgNwmKRReZd/LJXuUT0jqgdsSvj+IDXc80
         AFVjyI/Rce4RVmdQTlRSxXWRV/MQfc9d/hXHqtDO5J34DPZoUWT7Gn5SYiL12c7d87R4
         ZQkXwek1ZTpx6Rx5W1H0JkLIxZa0mQT/TPpagU70KJGznX1Zrg0S2G+rerJ63dyyKt5d
         UuBA==
X-Forwarded-Encrypted: i=1; AHgh+RrjGeZooRkTmO2nVWJbnw6T8uk+TinGnuNAChRLftO4DP1fyn+2U5ZtNlaDRI6RiqLP2g4varlV53U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9d21olvX8upARQB3yO+a+KynKrxXgzFxEjC78+zaJRGXC8dl
	McbMsAIzMbQhmUhfDvRCtGGhbN4IKb2DFO/0PEiOTwbW8MVGgM9jUKs9dGW9jxHO3P/GiMGkFnw
	owqOgAIqZCjECmSoQz0SVwT5VlOQcm7BrYltpz9ZjZ0/mOfSPCufIHhveHtMi6w==
X-Gm-Gg: AR+sD10V5uQcZ2ZQDYVJPOTOd/WJUbg1BtE+n3tG8rk8fLwzInn8Jqaa9qZweHAGLPo
	RW/sX5Su6NjgnjIQs/RDTBJgVsTdEqt8qYwDBCFnMcytpFs3lWyEhJCdWFqqE7+nU+1+3ABCC9J
	7SYIzkNKeKXx529Gm4PSh1Cj4UpkJHOq6XlMSRmAQfuFz87JYdfX4xTncxsFiD6ydpez5qpLrXd
	zxLFGwhtMmrZOq8Krb1YuMUtBursPEW8i4LzshOydIQAR/BhYC9qXBBqdcMeoz+XpN1R6rd72Bt
	IZ+ocZj/eNf94KNsp4U5OB6NSJm0UXjj1lTy+lzQ7G9kVlkY6b5Iob3hzfFt9UyxsPgk7WTHgrZ
	l0kZzS6/wOrT7BsTpvetlBnNc8tdI8fOFdm8=
X-Received: by 2002:a05:620a:4155:b0:92e:c117:5ed9 with SMTP id af79cd13be357-933027b2503mr400518185a.89.1785268673113;
        Tue, 28 Jul 2026 12:57:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4155:b0:92e:c117:5ed9 with SMTP id af79cd13be357-933027b2503mr400515485a.89.1785268672631;
        Tue, 28 Jul 2026 12:57:52 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7318180sm6491685a.28.2026.07.28.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:57:52 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:57:49 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 3/9] iio: light: isl29028: remove
 isl29028_set_pm_runtime_busy() helper
Message-ID: <amkJvcZGx2Qf4qL_@redhat.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
 <20260727184755.2055414-4-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727184755.2055414-4-ekffu200098@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Tue, Jul 28, 2026 at 03:47:40AM +0900, Sang-Heon Jeon wrote:
> isl29028_set_pm_runtime_busy() just calls pm_runtime_resume_and_get()
> or pm_runtime_put_autosuspend() depending on its bool argument. Call
> them directly and remove the helper.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

