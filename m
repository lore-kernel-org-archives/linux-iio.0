Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514336;
	b=D9lJpC2dLuKgltXgtfOFbMHzH2DtBRVelfqMCNLrjeZicYQGkEYvf8+WpPfaXF83D4JV
	 SQZJtwUC0aLI56o2pqhMwAVU90EhtLV1toxSQ/JBPuCGA5uB3hk2vS7VSx87sPdnMBmR4
	 Wv+kMONaRjy4bntNV4oW6x9b/hfS1VGHY58Q89eU5JCq/MI7vwZpurkW66vzyuvDENFpM
	 cFM9Q0GEiZtgEZEsKGxeKtkL+WU3ljIXei1U0QXecuEroB9ksSWOdQsmQb9uC/oE4TSC3
	 VYKheRUOtUKvqY2kXr+cNFsD8zVU2m06XZVHkYQIhHTuRyCliDfDZLTk9ECItf3izNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=enhyFaTlmSe8qk8N5fvqsVTmYc4LqDIJpmhNr1L+Z9o=;
	b=yVJZbJj344B28qqibTjUfej42iWLSArh1te5MG1t9WBeJw4XKp4v0Rhby5sVdYaDEB8I
	 /h4sPNpFxxxO0BR83eTazpOGINYVmtb7qY+LHZQ+1MrCpDoD7WnqMv5HJX0gRFmRw5Aot
	 5R1NTaUAt33crouVE41dDgYpin8r4IvmjVPytnJH28FoeGXNKfORxw03yTQ7pF3FsCfch
	 O+luNYHsXOZ3P+aj+NG3I4GE4rg+1BN0glXBSoGsfCVgQt/p2hOEt/nO/UCQTgOXsipHg
	 Vt6oIopEEydpuRXfMoNImRmAqkin+Ch43CuGaf05cZ2+S76YsBiMaqDHMsbk/rQ3keA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COQMd70Z;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BD606A321
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 20:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COQMd70Z
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3791619605cso543717eec.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 12:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794514335; x=1795119135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enhyFaTlmSe8qk8N5fvqsVTmYc4LqDIJpmhNr1L+Z9o=;
        b=COQMd70Z413zqJ2b83x0DveGH91bv22XH6Fu5Dh63m8XVUoTwCuc5f9GtEnVzY+Bkd
         yJf/TdgURq9P7AeNueC4IPw6YG+Sja1eGXQOZjEsW+kTQDMf+09aw/UCMNIV8SBLIrkc
         G+pq0dssMQUu1Ft7e1uefalVUKBIN3N8abtazJY90TRuUtWk0lKH6UFyDEGAcsrVBxd8
         Pu7ZlpM6GNbVQmZgPZu40vf4795fG446BJ57Ic2YuFq5QDRXnzEEZdUTWTJhik0n3/52
         iygA3IjK3CHG4/+BQpyVkxvmqeQ8p+vjpir+UsOOOZEieT45XErNImj71yXK0/i4TzJ7
         GkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794514335; x=1795119135;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enhyFaTlmSe8qk8N5fvqsVTmYc4LqDIJpmhNr1L+Z9o=;
        b=KmclJyIY2NilCMEHP0LiYgly1s92us+Jonh9Eedo3q2PXdHQyNgWn+TEr//l1kpXBG
         ynfpYNRtoMjlinfD+jN2JOjeDcWMXjihsMOTk3foADP68Fy+G1P2q4w8Aw7H6uYVmyGT
         FLYywFgaQPWPvDFSzfksB7ml76sXz/rp/akiRMheacW8O8+Epthhpj7wlePe6ypsm0jW
         wfy8RHe9GlPyxJMOsaZkKewJ9KPRpLSD2J6TjK6ZIBLC9DvNkyGT7mGgjWFL4e6A+zdm
         7iGbCNsTQr66NTNslTX2cxbbYVJfUE0IQU1GH4JP4voO98rGzDSHOC+o+0DYzvAGbjyG
         MH4g==
X-Forwarded-Encrypted: i=1; AL+hErGUOVr4Ok+VJmBm8yD+SWVQR7xx7D6KM/i/cXVgPdx4QM/NRYWwE6e9EM51Ny7qfgrHwQemMOGSxPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HGQP83m6jhs9s22d8m1lgTOL1zY2AJ1SkBTcXZOuGC+NP1PYd
	WawVQlk5hYJT8KwxROsm48+I9eWbCyPMHJMmp0jJU1hB3WcOmCbzmW03
X-Gm-Gg: AYBFou08JiyDbUCxh43FtYZC+DzRvgbvKip7/AYM75KGpDHjNnNVmpfeKcLbEG2RFAt
	9Pn46/w8ifwPMZQ3n9mnpx88fEQPl4tOUTDKyKVfa3cUGItse7HAC4+tKhUFOfjUzlTn+2uXEDW
	J5/5F8oYf8G6BnA3MFIFzY7lZGy95FKbegVm4jBmk+X86591nRrX2Pw1DIorfjLMD1ngVzGmMp/
	74SyjTMJSspVoj06nWoaABD0a7t3T3VOF236M4ELuqt8oNwmJBV025tAOMWezdZMA1z7JJfwJ4x
	sBrGeAzJ3/n5z8gJEQKyvw53SBig7thD+LHBD/bmri8g5PSQQ6R2+YTLU//RCZxdqoEph3Tr5Co
	vszeQ9Vvb6v3NcmAkgNjXlL2gBx9S2EmQ0M1cPpct68EWIYsuIHclu83+5txV/kIBGttMFf04Fw
	pEVX4YStZaaYb2+8n1dOSkdhUyNSssdO0i7VbTuF05gJwWEqzgjBKI5jdJv73z7LXl+59otI6U/
	HtxYMHCrvMqn0HYv1Ak2OwD4s42uEcr5n3zRPy8IT6jnDcUH8lDfDLEGvqvMjbSfGa8eOQET8J+
	vB4hiyGDGXIp5wtrxPdOUH+dwc4ald+LQiDa3G4Oz/xJyhhvk/bsqOtXslhBgFfzmf05TYLPPIY
	7upFehriWI61461G/twqyQwlp2H0hUW6MVkcMyhyCo70G+nG/Db9wltrGFHq0RaJ0yJ5OQ9ZH0K
	j1/AUNQcMxxOPUw/ccXERVh24reIrLQn/0zbXSAhWgGA==
X-Received: by 2002:a05:7022:299:20b0:1a9:cad6:5b58 with SMTP id a92af1059eb24-1b503150119mr501572c88.39.1794514335221;
        Thu, 12 Nov 2026 12:12:15 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm1908017c88.3.2026.11.12.12.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:12:14 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mc3230: Leave chip in standby on mount matrix probe failure
Date: Fri, 13 Nov 2026 01:42:08 +0530
Message-ID: <20261112201208.476450-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110070206.1452-1-laixiangwu@cmss.chinamobile.com>
References: <20261110070206.1452-1-laixiangwu@cmss.chinamobile.com>
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

On Tue, Nov 10, 2026 at 03:02:06PM +0800, Xiangwu Lai wrote:
> The mount matrix is read from firmware only and does not need the
> chip at all, so move it before the WAKE transition.  That way the
> chip is only woken up once the remaining steps cannot fail anymore.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
