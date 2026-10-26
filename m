Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002411;
	b=metpSts6fP9c5OTyhvs7rXOIUDPNH95FN8HJPKyuRd6G0pi8/XZlJ/gEiAd/MHaSMiLW
	 12mjKetZiWpZpm7WtpqGfm+iJIGUAplu18tNNdD2j/AWsEjKVTx4PbdsfOx87C5rDXZFj
	 mS6RhZuenmIabaft4MskXXSoxXIBCJNskEkeIerBqqaJDQx0Zoc3hSawka2udLOEbScVj
	 s/H6Qr0KZKVVcfT8QgxJnbtruILnRxYqm5omco6f6aEAK7XR3jCWJbU2iuTetG8Hl9nbG
	 JDiuWw3Br0Jvrnzesn8AHuAxXwD+caEvcjib6uonZAWxm7u6rNa7TmYqDu6eRsi1j5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c8wD/NgRN1vKnswesHA4v4xfkwqTNGymHPvs1+drLPQ=;
	b=kFG+u1JzUXU8Smjk00UG1ZOzUnCsPzc0yCRM9dVUTcGeLk/JR3244CCqsRmF7CttNKeO
	 H8Mrf4rseKDRN7gZ6WNilDRs5ue2GBBBWejjM4ZLKLGap8gWikanBrX2Nr6J7eOf81j3a
	 6FCvn4Fjb8+7iEeFD7dRoMYS5JOpzez37IUsNp7hEGiIX8gK1hhv+wI1+5jYcbjbtV+M5
	 7NOHWuLw4xK+XmRBqNwb4SkobqinbmKL0iQHed9LHp96DRysKsQgYWtEA2v7JbCx4bN8H
	 uJ7fy8jHUgpg5k0yH1xOvo/r6YGtwzGb+I/wriBwkZZQEtS1xw8au0WIdmyOW7WHLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c8yC2OSE;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7797606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 08:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7797606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c8yC2OSE
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bfc2ae6e9dso123014e87.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793002404; x=1793607204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c8wD/NgRN1vKnswesHA4v4xfkwqTNGymHPvs1+drLPQ=;
        b=c8yC2OSEPjjy8V7oBRN61y2M/0GWFZHgDZoSlFSAtUPwNLmT79evOgmDCrPmurAqXV
         n4tJGvjFemnFdh7uC9CFdsMYD+pcfenx9HYz6rr2jhzDZaYjQog9t+8jaC/k78WeiwiH
         0S+hBiPAFoFVIXpRtsP2QyGpZSZe+BJ5g+xNPi6eodToio5qwQLGzZ+2VaqEk23FP8k4
         rFOz6LNRZY3TZgqGYJV5e8bZcbT+uTvY9zmvDKR2nXb2f9PIj3yL4YDHo9QO0+iAchP9
         CL71UQM8PklWePpe68gynaTxp3K+dbJCVtVSCTjSr0tI0gJY9pb9DhEQL98lfq9bUfFN
         xjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793002404; x=1793607204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c8wD/NgRN1vKnswesHA4v4xfkwqTNGymHPvs1+drLPQ=;
        b=ZkkcyrL8GoMvpp/jiDaKZFqmwEDOS1FaTOQBcKZSFNU33hhzRAo7vnnxMYCVufsRT/
         VcLrywm7H8z2OEvqfSpU1UeS8rbUh4srRyCxfnv8r7J5aHePY6SAiNVFqKzK1Lng/dlb
         FGMNJjIvftJFVbnszR7kOh18Phn8gMGHGE2JcStsZONC41ZTjs8zuZft81fxMvB3LvB/
         LzrJu3DZ7Jc1IgGM+YMqJxQ2NjgjIROC4diNjFQleN8V63DxqCRrNFkK0eBAJqdWY/rw
         du4y8TJPRwPNPfAC54GAQi9tgg6ERke/s3li5K53wIgFJoJzqpWcNzY/u5d37W2FuO7W
         WsRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSS7bS8agdZG/7IDvdIiDNHySdjpMBUKNsbeJkaEwmQ2xneAwLdeoHmb4ONeZs0/Ou+x040eOxBDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvVvYqAsuxMz1h+8BXyaDQKop0AVbtr0NLW2PvDJRdYY85kp72
	/JgtSC0KSyfa+4ecsXqwJk/vAhLIhyKEao9wZ5f+Sl9n2N2hpTf6i0id
X-Gm-Gg: AYBFou1INRD0hf4PEeK3Ar1dbllubu2yN9UpJhK1v4T7j2YSBpObvWsEEJn+lhAUWbJ
	4oq9FsNXqBd6a8k1BtX7CUCUCHR82rnzAuWcdh9c1zPZP6fO9XzeEqdd5FP/rifIEVkbEgtnjsB
	MFv0FsgtSdR58ZxbNLiFz7s/Vcapg2o7E395X5nnydIYHqC6XWePsJfOS0RskkNieCF5XToFHv+
	RJuyoYaXmXiy9La6zqpdVXgP4M7iDTOfYC+5VghfCyygLu9a7RjllaWr2mMzKHzfgcc9TuLE4ju
	XejhiaikKI6kXthw3fUO9F1iBh3jxQCOtEIs4sw+i/jml8/uvn7nz5o4UdqDAwIV+w4yS1y3kRu
	wHiSHqllsZrg7ZTeQ+pMotWUR0xvaf/PfOWcWSmskugL2hG4JYWACpXTO0f7ghBeqN1KhbF0Xdf
	jBaa1IHFKhveQTkswfmvx0VB+AXYh3qN8uOpT6qbBwExCRvAZkYx5rJZAfApc4kOflDEvj21IC7
	iN8hfuKiLyBZK7lNP2ZQgvIILj4wGog+Ttcpp441LtWgXjThltSmHbMZcgONsH09XJe8yDJK9ko
	ILEvI8hdqiOISKiHoZZuImsOIXRXqP/oqPf/xYt6H49UxQLr8MeOSAOFvv1mbQ==
X-Received: by 2002:a05:6512:3f08:b0:5bf:a42d:9115 with SMTP id 2adb3069b0e04-5bfb7171b91mr2214747e87.4.1793002403616;
        Mon, 26 Oct 2026 01:13:23 -0700 (PDT)
Received: from yantra.. (nekmmqusumz5xuyc5yb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:b52c:35a:762:9323])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb952a61fsm1177483e87.75.2026.10.26.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:13:23 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic@kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Marco Elver <elver@google.com>,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Mon, 26 Oct 2026 10:13:18 +0200
Message-ID: <20261026081318.318870-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025215954.73549810@jic23-hlaptop>
References: <20261025191510.22261-1-zoone.rupert@gmail.com> <76bbebb4-7337-486d-8f21-a39bcb6dca93@acm.org> <20261025215954.73549810@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 25, 2026 at 09:59:54PM +0000, Jonathan Cameron wrote:
> Rupesh, if you think that is coming soon then please just make
> next version of this the first patch in that series.

It is close. The other fixes are done and build clean, and most of them
match Bart's branch. I'll send them as one series with this as the first
patch.
