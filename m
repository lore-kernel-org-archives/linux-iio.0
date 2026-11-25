Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598252;
	b=Txni/uX+9ct9y7P05XW4J6zHPOTY5r8NDX9rVYYV7iucHmGOxUsDgpYGM6Tx0itG+q4L
	 9yRSjurtQprvW/UnvGvkNNlqpbH70WuAb8okLYKN+aZFZ6kUBdnvRGSnk1okSOutrKBSs
	 j/M9wdtr4kzuSte+Ux0TWWcuzi9LfewDxqE2CDrjv6khphLXjI8QFPPEZQ+klhjBdq31E
	 0/kEw5FSFHG4+Is6srl3C7BHwdpsDRTSfYokmR1mklnu5aWo/ZCq0h3ymsW+ChASZGZ57
	 URn06NnClVzHe9WmRCyGICfA6mMY1ew7Jjv8iecyilt+9iPJt8K/fyFkwKKinndw4EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598252;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TU3Ws57Tqh5M78uTPPJCWLPsrANZW6bevozQ5y9B8m0=;
	b=b6zPIraGf5khg4hkBnVYCNcFODYawkQ8UU8zwuatG0AreqT09Bi0Oyt9cioot3rV9uOi
	 6uM3VbWtOGCWD1iv819vqB1jAwz+X7dPfLhxgSxO+MptcpTm5sTuivcxqrJF+TFFPHpnW
	 YM8ZRnqi5T7Pdd4XFPL5s3uTOuzo6qj7XP+k3nJVo+m6OJDj0GKDeIQAuFuqwauR0x8+U
	 s5qWVpL3gcWZSF56jr95dpEoE7cxYYQCQA9AnrwyKw4yjOkzDXpb+Lkab6+2/exO3Y/Kv
	 v8EZ+hSFBF+zEE/QCp/jrRUNAIlVUdd5G9UrHsmMBLUd5H7dLAmaXD8eE741A8NlIzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GH0lCYaM;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF7606A683
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 09:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82DF7606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GH0lCYaM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795598226; bh=TU3Ws57Tqh5M78uTPPJCWLPsrANZW6bevozQ5y9B8m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GH0lCYaMMzOWlmXxqsZEEnyoIcKVcko87uU7CtPMy3tJU/hTBINDYlds2MyV5nZyX
	 PbQTJmC8L7p0SVL1MHAgkoRm7gzFMzAR0MoFo9WSMseVLhX3MXErDcNXOSlaF7Ytr5
	 VcdNdqjsMSGxyqFe4Mg/edddGnOp8oEIMSOh8Od4=
Received: from runtugo-virtual-machine.localdomain ([220.200.111.239])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 43510ECE; Wed, 25 Nov 2026 17:16:53 +0800
X-QQ-mid: xmsmtpt1795598213txpkzf1ie
Message-ID: <tencent_945BB9A3F886BF4E33511C90AD6F89C40809@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuquLCMXRl+ToEvgkYb/TsQlk/GnWWcoI3nkJZ0zxym62ioojM0h
	 tg5bjR6u64kluQR4mG5YkiCWj9WMKGSDW2DyO9zJgBnilxfxnjg4hTVn/mqO0JHk1QaLOVT1P1aD
	 9C9foD3mrB5e055dktd6/YXWBtmTt7cI1g1zejsse8G5Tf5crmy3TnDqKJdAKtoSoJRs5ZplDIQi
	 tMIcF1KF1uG88yH45FNjW5PQEyzbX/TEGHAoLxDm+LdOOPmUUOVHEQ+itxcPmbTfGQ9M+aogfNl0
	 wOvt930mNjZHGjKBbhegpTbTP8a1L6iSVT7COGCgL2xasZCtSo5CodQJVzmd76jYr7aE/poauGYJ
	 31Mum8yTbGeeBOrCVqfeXX3ExYpoPxHCmJTIfGLO8tPqJHq+wCIF5Moo2R/zKFvDv/x2PhfW6oSv
	 kE2JpGo+/Wo0LOqfZylf3pNHWdBRpz8CVXmJmQ/VnPMUeVU3lxueT08WFXEKaE+W2ALuOOt9Oqll
	 Omrh3RrjIu1diFF34Yjal2y3Gwtgzs4E7DthRQCdZUSk+BTn3uW3oNAS4SerZqxpv5gG5YKgrA/s
	 7JjeWY+uCrhlXgBIvRHgM/RD3H67j46uUM0DXvA1a5O64gcH4TI2a2DAauiJTm8dtyyB9me0/z+e
	 yuUsKLzYIhm8w4AMDVSvJtkY27eqdl/Q3jJBcN7qfEspb76ga6PMD30VuCrR72xqtMavAeGfCBAq
	 zalSkXDL0b74lcskLCBeaQUXe+d/AJMd3R3YCgJxyLnsn5+P9t5SAjCCknhIGa/kQrAMrgF5X7Ev
	 n4s6paAVdHqskQP7yIDF2vrLIuO8rIQRvgJsVRv/HcEw1HRo+Ti7CSYmp2+YGzQgXVFZzBa0a2e5
	 XvEe3zysshkm+ebla//djeRWShCuKL8AlSXKbpNaN3I39NBQso01X7gFEsh8YmzJz11WJ7GrSfVP
	 h94WFo/cA5mfdE1clmVHEBLvctoMYgi4SQ6pGR3Bqr9tRzZ16R1q0xbOXceZ4e8mK8qacEpLJePE
	 yNRIi/GtdG8aMekmuDsWeSs2Keffo=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: liu haojie <2669793217@qq.com>
To: jic23@kernel.org
Cc: liu haojie <2669793217@qq.com>,
	kapoorarnav43@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: buffer: use cached timestamp offset in demux
Date: Wed, 25 Nov 2026 17:16:52 +0800
X-OQ-MSGID: <20261125091652.13575-1-2669793217@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124163456.76469-1-kapoorarnav43@gmail.com>
References: <20261124163456.76469-1-kapoorarnav43@gmail.com>
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

When a buffer requests a timestamp, the demux source cursor only
accounts for channels copied to that buffer. It can therefore point at
trailing active channel data instead of the source timestamp.

The IIO core already computes the timestamp offset for the active scan
mask and caches it in scan_timestamp_offset. Use that offset for the demux
source location, while keeping the destination offset aligned to the
selected buffer layout.

Reproduced on STM32MP157 with the icm20608_iio SPI IIO
accelerometer/gyro driver. With only X acceleration and the timestamp
selected, the source timestamp belongs at offset 16, while the old demux
read from offset 8. An equivalent downstream 5.4.31 fix was tested across
126 channel and timestamp configurations on hardware.

Fixes: 5ada4ea9be16 ("staging:iio: add demux optionally to path from device to buffer")
Signed-off-by: liu haojie <2669793217@qq.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 42941018..6727f43b 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1115,7 +1115,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 
 		length = ret;
 		out_loc = roundup(out_loc, length);
-		in_loc = roundup(in_loc, length);
+		in_loc = ACCESS_PRIVATE(indio_dev, scan_timestamp_offset);
 		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
 		if (ret)
 			goto error_clear_mux_table;
-- 
2.34.1

