Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120233;
	b=unWqiE2nZHpOSZ4HDp/Nbjf+VHDGKNZMIx+hMHGkyomMMqNph+LYWCuKXi9nZAi63AkL
	 qAtPCLBDN+Ok7LpBpOINIECKwLzTU5iKfQF7nECB+mQUhRT4l9S0yRzcuvRriaKMUzNJD
	 zjQI9WZIZzEnHWT05kaSZBhorJaHpmNUoWWm/FaUogC5+aAsb1e1bxPJ9alkc0wTca+Gf
	 opm4vMXhXZMpVowOuuLs9KwTzi54QPmpSv2o4VCNiaExT0PYEnJSBJt4R4wh905Dy6cAV
	 eB8d9dooxPSCh+BbC/R0b9CqCDA9ns4ek+YHsBkF37OFt98CEG1wEp+xTaoiw97+BSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120233;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Ywe4HIjB+CMojZib3S62i/ySQjR+qizh8Bk8cJSE1aE=;
	b=2tF1Xru9e6UdxNqw4MnJ8u0IvbdeTdmUfwD88Wk2R07PhPkS+RTNEaZ90RZyoi61TINW
	 MZ61q/uHk/ygaYYGqkpj9bxVWgFml/wBFPaH9Le2F9j5NqlYztPlGBu7eojb5Olzd873n
	 UlYTy+lYXKlhNF8Pe7tBOwTGlv3Q05iQyqWXTs3N1bX5gFCznNhjmeQR09mEvsqVqGvGs
	 7Qkv8a4dWAcGOxOQiPUwxNokcr5kd6r4doO/rp52Dc3nQ4448+4J0Raeq826u+iSXORgP
	 v5oHVb442Pht0LAQWfiiNm56VWO2D4vC3/INGZn+PVVOTNhdTWn/7MvmKinShL9bsgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BED606A31A;
	Sun,  8 Nov 2026 06:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94BED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnwrcdGvBqpCOWAA--.35723S2;
	Sun, 08 Nov 2026 14:43:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, petre.rodan@subdimension.ro
Subject: Re: [PATCH] iio: accel: bma220: Fix trigger reference leak in
 bma220_common_probe()
In-Reply-To: <20261108015221.327af6e9@jic23-hlaptop>
References: <20260916160823.2082283-1-vulab@iscas.ac.cn>
 <20260917011518.297868ca@jic23-hlaptop>
 <179396508376.2291875.4312877838122457985@iscas.ac.cn>
 <20261108015221.327af6e9@jic23-hlaptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 08 Nov 2026 06:41:28 -0000
Message-ID: <1794120088247.5921748.1359043367598265564@iscas.ac.cn>
X-CM-TRANSID:zQCowAAnwrcdGvBqpCOWAA--.35723S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY-7k0a2IF6w1UM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr
	1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k2
	0xvE74AGY7Cv6cx26r48ZrWUJr1UMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07j1tC7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEFA2rv42BYvwAAsh

Hi Jonathan,

Thanks again for taking the time to think this through; a general fix
sounds much better than patching each driver. I will wait patiently for
it.

Best regards,
Wentao

