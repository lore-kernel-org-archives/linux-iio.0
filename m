Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767798;
	b=uMTALhZpYr9shMckIDOH2WmWiECIa0HyzRqOluuBQTuRN+Np8QE65O8pcp9BlXw/dR/k
	 vkfPkda92nQ1qtVMXAB4Qx/mRUCVf64Cn2/v57NY1kzHfs84MdPjOKQ+qTlZAFHYr1l72
	 64dh8UIPYtPiwQbLSERISqydNRPFqJ0K6GypAxxviXkq2mHg9m9lEPQ6nxA272zeWWrgG
	 YGMf5SWxFfR7bxH/syD0GWYHEg4f/oDTqORWyhg8u+V1lS1wYm6aXFRYsZextLNyyC8zA
	 UDn7uh2PQS8lBNBGxX/w3gW1F8o5DXzJVN9XLNUudQsjR3j5Z8YOjw3/LA14tDtPv5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767798;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=KygQwTUn5TqDn2zoXdD+ostSlf4gEhM+vvIOlkcF/CI=;
	b=BklTaTpQ9GkZzAo3JeVqILSa/NXVPn5/Z/21xCyLYbu68f7B2kN3lDZ2yz1AG+q3ho99
	 s8rZjdBq62Y4tR/ZE4sh4YJJnL0zRh1qNUF7nOukf9jgcKeNxEi/+kmMPpTS5pzt5u1z9
	 JK3VY8VMNHOpn/+PGA4knOM38WH8SbwGCX9h3pfq2q/Uk+HJoBeY7EXnm1P4vjr/lIE8F
	 gj/vADtCJ54wyCMYQbDqUNP6/JmVj55BCS/JhoWc7SclM6WAKVoUJwK2xRqkAQIstjWVX
	 nZX1g1NWTTbolpJSuOMDMP5asN+mtrET4c8Q+TOkkEzVH2DVoAsET1Bdnn6fa830J5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248C606A31B;
	Wed,  4 Nov 2026 04:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A248C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXZZZsuepqJqdEAA--.887S2;
	Wed, 04 Nov 2026 12:49:48 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iio: adc: ad4134: Fix duplicate data_read mux state request
Date: Wed,  4 Nov 2026 12:47:19 +0800
Message-Id: <20261104044719.4120078-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:rQCowABXZZZsuepqJqdEAA--.887S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1kuF18CF43GryrKr4kWFg_yoWDtrc_u3
	Zrua4kXF1xCF47J3ZFqr1Fq3y8tr4Fqrn3Zw4F93ZxG34UZ342vryYvF4DZw1kuryvv3WU
	Aws8Wr1Ik3W5CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

devm_mux_state_get(dev, "data_read") is called twice in a row. The
second call's result is stored directly into
st->mux_st[AD4134_DOUT0_INPUT] without error checking, and then
immediately overwritten by the first call's result.

Remove the duplicate call and check the return value before saving the
state.

Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iio/adc/ad4134.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index bc6407ae25e0..35fe387b9ac8 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -1112,7 +1112,6 @@ static int ad4134_probe(struct spi_device *spi)
 		st->mux_st[AD4134_SDO_INPUT] = mux_st;
 
 		mux_st = devm_mux_state_get(dev, "data_read");
-		st->mux_st[AD4134_DOUT0_INPUT] = devm_mux_state_get(dev, "data_read");
 		if (IS_ERR(mux_st))
 			return dev_err_probe(dev, PTR_ERR(mux_st),
 					     "failed to get data_read mux-state\n");
-- 
2.25.1

