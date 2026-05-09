Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB82BE656
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293658; cv=none; b=aZ2VbtlnVYKgqFeuBkUJPcjb7NwpJjKhPp4muNPsJWx0o79Ov/+5OeX5PBuSJFKYP5r8VRqXSx8PdPtD+y16pVpYpRxiyReVr+ID0BMkNIazw6iMdxwJUvYtIqHSqBgh29+Ew4ZhTbDCX3vwzVdgyIBUjH9V/sMzp7zTCxkfmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293658; c=relaxed/simple;
	bh=IgAQRV3Q3aq0oHVCdM+u/7DsWjzM7mluG5CGsC4diZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bIj/mK6NN7TwOVM+bORqDV5qQBkYHFxb9efGeDNqPczOLOtbMQlbGZEAq/e4Q7sD3nLLsdd29NSgvpnB6u59fm1ivAr9/pOO7vQA6eaBwRKl83PWaGtw0Fpq/k8Lvmk4rDDgILyDru1Oy5cwswUc+zmcXTHzCCr6LQ9i32hvCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJEr+Ymn; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJEr+Ymn"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso2663857eec.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293656; x=1778898456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kq9J8CDDfMky+oADAgeodMae7ri1gSkXKgoeSxG4RTo=;
        b=qJEr+YmnRqaPGcRAldozWHSG1Whyyls82VSP/GT3jHIuRE5ZL2v4y88MgvqJ+EIlwP
         UlxizdOlWxwqwq1TWpcN6OYOS1iUykr8Es8jectvauhGaTKRcNFPVTM8++hgoDtN6c1Q
         XrdREOpAGU1usWO+Rx2EN8EHxA6HQpPpdkEkNd2vJrXd0gNmD2eQ310LS1M56y/GsluU
         6/LMl7GyqgdCxbOdEMOJnKp9uzrxZANrpPHhz0Guxx6qwokDkqkadajgTqkbx/XmWKVl
         SqxUJPyEBEAc4j/sJr9CZKNLwa6BoX40ITlZIzAIPtaj1J11kgAQdfu8sv1Rh/lpM/M7
         h6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293656; x=1778898456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq9J8CDDfMky+oADAgeodMae7ri1gSkXKgoeSxG4RTo=;
        b=fM4JVeUJa1SdinbQqErW0y95iQ8u/7aaA3bmoppPlJJfazl2GpK3+XprD/LWAWvLx2
         m7k1uz0MrepRRR27NMIVF+VDgTuDY8nMNMdGZuyI6KVkUma+UucDvjWzSGERLjWP2ZsH
         xgEzBtQarnJBmoly69RzzjpqtSukk8X74qafg7qSUjVlMBtN9JWdWlWgzp+7ChP9sLHk
         KJRu2RL+t2HMOula65SDkgXur3csc9zuzu+fvfo56ywQg2oGPWxHZe94J3YAkfDfGR/z
         NjwPuGqwpa6H8SyW8D7TADB8YjXT7fr5itamda7dGbL5M2tmHpj4cPuWIwZoQdkdZAG8
         WHPw==
X-Forwarded-Encrypted: i=1; AFNElJ9Dlm5wQ91ym9exjXEi6v/4rb8jsdmyJpOOzsZ24YlKNyR/+DFF+pFZgfey59rrx+D2+m9VEbjIvac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOWhPM4fmyEVcgwINMuRBMuYs0ONpgC8sczUmf5lZaiDF1QTv
	Ec9LkqDtSvDjjxB8FUDjS+UJ313K8yqNqsm7c1DrKwWqUkx16IsnqfHq
X-Gm-Gg: Acq92OEURrp91l5e37lpMd2O5yNZhPs64AaKSCKRqIlIfhudIu8CdqRp9Y3Dhc7ZWvr
	nqD97idGgfq7d8mSNj/24qbrE5yC/b+QpktzTsX8WMcbv3h5GdhybcZ3GiNn9saKRvf2oX26Wrh
	usUwU7Rpeicl7Tip2QPx9EA7au4a12VZiiGSwcOa4vbr7B2vG51it4GJtw0AH1F1iNetXz6tKqV
	MpcO+Hs3uF9Q25gXnNquD/U1oyZk170nwUiBzA9yKOfCIhUyr8eTuJLVXU6ZUp4tOB8k9vUorXw
	Wzjemytk0TD64mtElyUrjQY/ez5UVTvRv6LLWcFWiCJWsQTLHS4ON1tngxgQqs9WzSLqHPyaD4a
	fykSNwfWFxD+wrN7saezY/PJYe1U+Rd9pN7UIUAekfAfzMdASl6icia0LGDunwCPRDVKLfONdkI
	78Ps3dBXGuBa1B2wqEJETEPk+3xNaTGiZBTVwRnKqQflyydWeNSHGK7QKYVi54MmHYZA==
X-Received: by 2002:a05:693c:3b0a:b0:2ea:b975:3db1 with SMTP id 5a478bee46e88-2fb4dc6422dmr290307eec.23.1778293655670;
        Fri, 08 May 2026 19:27:35 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88924af95sm4689640eec.30.2026.05.08.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:27:35 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3 0/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
Date: Sat,  9 May 2026 02:27:17 +0000
Message-Id: <20260509022718.82957-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Fix commit message based on input from Sanjay Chitroda

Changes in v2:
- Fix commit message to match binding requirements

Hungyu Lin (1):
  dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding

 .../bindings/iio/adc/adi,ad7816.yaml          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

-- 
2.34.1

