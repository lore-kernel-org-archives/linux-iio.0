Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641248;
	b=ZLdKGt6KXbHjf+08SMoBX6e1jbI95Au3a385BZagHrAjwSTrzMntn+8EJFnrwR3G6wgS
	 /mM16ix7WnCh+ZDUTavP1i9H9J1ujwjDAudnhnd5vO8uAr249r+1Uhz8SuWc7DaBwyR1Z
	 daj931vTPt2diQt4cSftmu0Q78dXNR7SEY0w2dafEMLWJ7w+cn6E2ctYJfT5iFvftP7FR
	 MPF2qESI5QfPlNZUkDIDHC1CqP8ObzxNtI5Y/aGffNEyirWPvbH2hc9AztmcRjWI0F0R2
	 oiWHnAayZQZzFNWmQeVCsyYIVnwFMnKm3g+IN1egBWaeVIkJsU2t8lnTJ127MWkNywg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HRL6vIGNzmBBlS3DC/VjwZ6m9MHEtJ+5vgV+r63OYc0=;
	b=wI3IfZKmZB0oVcvMB9+AGdM/ZoxKRmKOWRNloC9cUv5bUpDLWw/bySu1gZ7Vc2VUsUQQ
	 /gCD5a9Qk1q1cLx5Y0pDhor4kBsl8bFICqPeq+cDQBkpCAZxPoMsY/8uxixFu73EO+UMv
	 iyoaz76cGtz9Gh2xmDFBYEiwerzrSioXuXEYTNaYf9olMW3CKF2shd5oB4Lucpe0PLvMr
	 zsTbIZkrgyiDFgym8VMJsRD+VnVTZWGoQgMdsmIa0lqSMvJeqx1vXc/Q9fekuJqtP/UhJ
	 +2tYWPkQrVCmtKan5CnpYXxAq7PzF5pNQXiUkcPwXYwi6NYKQ5RxqlW7ghQSvwv76wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIGXU3Z4;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B3606A329
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 07:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A9B3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIGXU3Z4
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3417614eec.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 23:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794641247; x=1795246047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRL6vIGNzmBBlS3DC/VjwZ6m9MHEtJ+5vgV+r63OYc0=;
        b=qIGXU3Z4jXmEM9CVu3DsWA2oTW/VefTlhNjJk5xexnyCRaPHMVrOEt5ZHF5tpSeo+S
         yVZjdIsrjqqTw0QN9xKxIyPoJYejmZse+YJsc9al/rsEAO7qJnWxUmKiVQ7N3EJFgxdD
         qUcoGD9oWOj/Pw5ehg3zurOY0GjHiwsBmRPflt45AiWZg/HKY2q4somD2ncVeKUaDyup
         hjeZPNdhak+QPasVFlUhs0gc5smXGuAeOi5X0GBJMLo4Nz87M/M0R+palV/EEOerBI1t
         /0yhaOszCGlK5tKDfLfRz3brBtBUEAJ6v3WJLcW17cbyRQpFC9Y0M3wSY0PQPbVDCrXz
         f6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641247; x=1795246047;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRL6vIGNzmBBlS3DC/VjwZ6m9MHEtJ+5vgV+r63OYc0=;
        b=t7JTHosoiEOJdNs03Xmx812rlULF8pA3G3QHddtiKlggqUCHsPip/kwskikCEiBavL
         WUrr+VnZEAJRmiafPSuVo3GqmpVg6Ml4FRDIi7MSjjYhdZG1Tpi5w03IBj5eyq5/tvEx
         5CLvPcMTdQdZF1DE/pQQBNn1fBDDkdWon9MIoKX8iLhYELkQAVIj7fCi4KMDiiEAQsm/
         e08LYUWUM5JTHaJC9rEsLsDtPFtjQKsU3RP+Np9DISALH+jft07KJ13cD04c6+1hDHPv
         wkIcMTE+EpPUDyBxJ+GfhmR7xskCN4IEkhTkTb4yBdrZd05c5wLRzDTlE5v+zXI3Ccff
         xrkg==
X-Forwarded-Encrypted: i=1; AL+hErHmoJBNdFEvWUPS817EBpAJt4B3lobXTPQv4EYYnjLVGCPChMVg8HKPkA87uYhAZ4CVUL1nPOijCdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pR8h96vTn1fJRk6F98BtYwk1EqymUrYq7Dn6kKlomAeNvNvir
	osJNhLDJUbt/fRtiwsx2qHHVhOqdSk2XKuqHu0GZQwmcI8NmMIOoHs85
X-Gm-Gg: AYBFou3cI4mDzcqOoYBaE6yMzKZ5JYmmitsLXn/HSiVecR5BsXSv9nY0SosWskhY2IW
	EU8L3Fbiq1FptwMl3F9MLECPLO4z9CF1WPKy1UDn3FUq384VpWZrTk4uPgG0lQKIpL9bo/vej9t
	gR8Y1T40Bt8//BRXgT5v0DwPO88ztSzqDwJe0qdknyNTRaBMADvxYa6gqOCds63XwAZpVhmsJgh
	BOiSgf3InWMqO8A3TMoDr4gKN8HCmLCLa+gJi3RdBiWIf0Abb+vuc5ljnqYmQ9OeNKoKJYr2esv
	Uj6675oVqlnVk1FeAB6lU6oZ5gLVAzASl4xlvpf9Goh0CAcspOtAivvXLC6j3ZxoxAhoAcKHazV
	H/DwkXHMPA+nLcj5yQ3w58BZ4bFfn1JThOPbbxScRNlqLx5M/L6Z7Jxw+gRj1pO3KvvZg122uWf
	VvpwgeoKMJVPVmzEdZVA8/1iXKG7wU/zhCCKQZF8aiO+xWZXcHZJjje7DNaiaSGnZM+bgyzAbH9
	jT6v93O7pyeGp/pYC02j+tQ/X6ZK8hT+1XwAUzeZUt+8mDZ2esVhM+wigyJu6iQVkBPITXYCwH0
	6xVBOBDfr3UnYLzkL+Qo2NoeSS5EAODszD4Vm/PJMluH8jiKC3IzWi73S9g3p1rHh+K2Pr7kBKK
	HFXDjBqbZnhOMWaK9vNlQeOMc64AwZALnBIOmspzE5zcJlqcvxZcYIR3OyM+bHaQPT5yXaFRlnW
	Nw9jyh9IiYFNisF4vqSCrFsp9slBHtCSLFQLId+zxkKg==
X-Received: by 2002:a05:7300:828e:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-37966a575camr4240798eec.28.1794641246996;
        Fri, 13 Nov 2026 23:27:26 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm25914706eec.20.2026.11.13.23.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:27:26 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Niloy Meharchandani <niloymeharchandani@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: use devm_mutex_init()
Date: Sat, 14 Nov 2026 12:57:19 +0530
Message-ID: <20261114072719.21558-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114062021.142296-1-niloymeharchandani@gmail.com>
References: <20261114062021.142296-1-niloymeharchandani@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Nov 13, 2026 at 10:20:21PM -0800, Niloy Meharchandani wrote:
> Initialize st->lock via devm_mutex_init() instead of mutex_init() in
> ad9834_probe() and propagate any initialization error. Since ad9834
> already manages its remaining resources with devm_* helpers and defines
> no remove() callback, using devm_mutex_init() ensures proper mutex
> cleanup on probe failure or device removal when CONFIG_DEBUG_MUTEXES is
> enabled.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
