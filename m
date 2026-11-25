Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614493;
	b=NxZhFV41lfni8XnYMhMgo0EjPVlY+QLaRAxplIWE7JT0UBP7Q6v5V53q2W4MTY+DfPtP
	 AnJb03xjEgK+0oAzs4Xdy3NFAzNQTgQQzm8cj48M0FkP6qMSghitilx6gaL33s7gNnOKX
	 xvKDjT16O8iIneJOdH3iLXXIAIEFiCsdFfeOlCQ+nqzDy5hsF/YRTXbukum8Xak/Pq9nn
	 vIvR/xaqitkK2EzV25g7AifCNeDS4E5j+1taQQ5LuoS+1ikIXOQlIVV7eDJIk5cRNeVz0
	 h+ETw96IzDTUKnHpR57aeYNbqpLAVqc8MK281zeYV3jMRp9DfWFeMyN/d+HSO50QSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O8V1Hc7V5lXg9nObnsnX07KfwvXIP56fS+tI17lmsds=;
	b=0JwW20h10xwi2Hi5dPVRFA8Ehhc1oDgo37CtP4SH/lr80TADzwHEiS3Qmz5tnn/60sqo
	 YByvvTQ7Y8FZ5GwNAkRmcl+ubj42XyQhKc457KE+oEU2SThiE2donv6RSRY+y+HiRwirY
	 M/fxP7yHVr2ANO1b6bW8KE7ipcORvW6RkJqjv5IphVZ7l5MQD55AVdVA9uVhXCvT3mFZG
	 /HEUCfsnbh86MBquIGf3VM11i36fWG16LVD0A0MPRoKIvT1g01egAKaPzHXBzttzHKqPH
	 cxnrgh9Zi/ZvyN7nrGdawbQc6bBsjayG1H+YHTMoloSWMnO0NaYARfGuga7lR2HJL1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aaR1+TWx;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C3606A31E
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 13:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aaR1+TWx
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38644aedba1so8784640eec.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614492; x=1796219292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O8V1Hc7V5lXg9nObnsnX07KfwvXIP56fS+tI17lmsds=;
        b=aaR1+TWxAptHpMATQVNPufcZKt59nXmfXXFLtihwLnjAFxKhM4DQsE1B363DSb1hfS
         l85FR5wvPBM1t9Xf852x07pjF3/s8rPulodtr/5J8tOfcU7XLIkNIJK5HzT5frl61FGR
         PytwLOFgEYtAj1dtGktRWIQOLgoAJzURwv+JqJxbOsMZgD+HcJekBbJPGUa1RSJITfWI
         eW3LCoo3hnpUtZiY8QJymkX+0FZnBvFpcdtneOgCTmuVoslHYnfj6lcwo/a/+Afabtp2
         v4QB8uonT5/N3eClk/bnnidXRveLjDaiw49mmAEg57OJbOBUjvf9hGsh4r224dK3MuAV
         4x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614492; x=1796219292;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8V1Hc7V5lXg9nObnsnX07KfwvXIP56fS+tI17lmsds=;
        b=pqWmfoI/YRJQUAtCfZz9SDk1tzr74lB2uvN02gE68ozo2nrvHB2Gz2PUPd+OrNDBxW
         8sg1MGdn78waCtTKLc0uTevODxKywa5MnMVlQUwdbGw2wuRg7UHqBbYqHKGShyEv4vaK
         amT5h1d2yazczDM0ib96VEJ8iiEnvQuVVF5O3NHW93LNPRW21NlKCHIBgN0kGsdgvvpK
         nGhVUFcwa+FHr8HzVEE0tp0TgLLplvQ8hNLjRxgNukTeFOZupyUPpkd1A0s1e1bfHmqr
         lu3YbNMApnv3aXxyGiZ4js1k2WUMNSh2Uu5ROP0QYH+Y88443VFNKIEqDNXUL4VB7pBf
         n92Q==
X-Forwarded-Encrypted: i=1; AL+hErHoKUaD+l+umm56g8eR3m3kc2F3l1cYWAQiqb++Zsl3AVwoCn6na9cVVbbHkCTjD2bsqi/bdZMRFAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pAj6uBf/yV4yho2o1TxnwP5hoybSd50tXBT+6BmXyhp5PWFrv
	/nCu8dxcmKRUDtIi1eKXxydeoSoSVFOA/RIgyAuD+G8Ts14dS35ytsaT
X-Gm-Gg: AZFdTZcDKEAM4rQQbpXPVjPK2YAKS9FGt2E+Z2I/J1G6mh2/zmcdjTGvebwCKvERCDA
	aE/6cQgWPlc0QfZ+jahVYqPuTkDNKUZ8+q3h+MRRbCUX1iMyNAhw65i5RJPUJrL3SYe7CHD3zoX
	YegrCImIpd3aMe4w851aHs53t0uX3pKZ7Yy6Jwc8LkuQYx5Au4KjGnLnBgnXL7TuY+mbYKaT0Qf
	PossHBm9HzpjA+/5LoIuXJoZCrfX2AQZDoEa9jF4w4j4OjC5WCpkSS0F5ZJGA7CNzQC54GV9ATU
	F65zI5ydX3ajOWjQEeO6jQVsdAMHJ5TM1ExvVaECDyS0GCrG4aL8BQEAC4rKhh1Xr9Tob3ItnKL
	UFBmasWLrRwvbWRHbFgMcd4tX5I8/I+UWXwGs9Y7j6CkkoqswmbeCW+w8Dy3jLcYGwnZFHa40qA
	EOvZeUfCm0BDzJ41EMGPSZC5iKZjx3/9YXQ4eXUd0uFBz3vlIZnN8LbxaSpCEimPlSRZxkKH02Z
	GF8O/l75T/hBFtRZCDDGmkmoz4j3kwoKguHndvJdctVZj1YXrjOJwC6iMAqN5QgWWBza1rRhOIT
	V8Pjd3q42seyEOM2soMmIpJUx6aXOAAD+F9I8kFEO6J+tKvI/jAto0JI+WGUFT0WVv4oo1cesd/
	48yS1w80pd01p1MgWNgPhw1MS8uc3CNcRsnDs831EigpCucoJTz2PJH+YLPaes/LaE5wLE7kfEX
	FuPLr2bxTzS5m4K4dHAOcJwNC3HGA8i3v9lKk6I6NJLg==
X-Received: by 2002:a05:7300:d941:b0:385:4b9:18e9 with SMTP id 5a478bee46e88-3856f94f874mr19200403eec.18.1795614491655;
        Wed, 25 Nov 2026 05:48:11 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm62148900eec.24.2026.11.25.05.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:48:11 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: liu haojie <2669793217@qq.com>
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: buffer: use cached timestamp offset in demux
Date: Wed, 25 Nov 2026 19:18:05 +0530
Message-ID: <20261125134805.57530-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_945BB9A3F886BF4E33511C90AD6F89C40809@qq.com>
References: <tencent_1EE4F65B31B1B056C2A8FD618D533F141407@qq.com> <20261124163456.76469-1-kapoorarnav43@gmail.com> <tencent_945BB9A3F886BF4E33511C90AD6F89C40809@qq.com>
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

On Wed, Nov 25, 2026 at 05:16:52PM +0800, liu haojie wrote:
> When a buffer requests a timestamp, the demux source cursor only
> accounts for channels copied to that buffer. It can therefore point at
> trailing active channel data instead of the source timestamp.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
