Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014686;
	b=DRBwen1zD89U+J3q7aAeq4TmoPpdnruy2ZLr2MmdBhMzBG4/uMbkyPLT3hT/bua88zmL
	 iW8UkpdPpSA92xyWPjx38ML94CDf2XoS5YfaE92TM2JuREivWGQLuArW4U1fQ7OzOqMSa
	 51xWjGIGbmMVupbkgwPG+pFsN35wICxtko+xJsDO5n6lAfSchWFulCPZUXKn4rJDWGdV0
	 6P8AVuof5qMXdIagRMb1HTONnyl56dmpGmI/D/SmRhwrlKm/4y9yW3C0WAy5ld3uhDT7d
	 oLT4A1ZViLqDbrShcUPIy+UhkGMQPGXBBJrLxF4otTguXSsz2RrkhvisrTkkj6k3J8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014686;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=uU/K3PQdZHjbnA0Io+RhEO0npMpqfrYeS+PS8CbfWPc=;
	b=Cgj8npkc6Al4c8qvKiWUVa0ASkG/keeyhbExLkIx1akAuZxyxYHc5tNOCX2DyX4LUyiF
	 igaTvXIf4gj1bPSpD27l8osu7DbUzufbcjyDPWallaE+SY/uA7/T+k7uXORgE38GCHJGg
	 p0GShEBsZNO3Qjg9DG7NCiDGCPqBytKCCwTMoRiqlAzPcJOc4S32HyQEfg5qVpxoNlLi1
	 XylP8oTVpgzmE4GTIDwkwTYIlt9cwOrymBRIX9atK5nYW8TpqcRdTJ7modDbSkQNBXsNE
	 ViH0xDTqyys/jekV+a5O9TPfRKp7r2iYX+O3PRcYLwwXXpKe9IjUWyi9T9n0lnFx18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yosoro.hk;
	spf=none smtp.mailfrom=yosoro.hk;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mR+rFAqE;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC16606A31C;
	Wed, 18 Nov 2026 15:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yosoro.hk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yosoro.hk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mR+rFAqE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795014680; bh=uU/K3PQdZHjbnA0Io+RhEO0npMpqfrYeS+PS8CbfWPc=;
	h=From:To:Cc:Subject:Date;
	b=mR+rFAqEyQfWhDYRbah/noVK/8ZDDFqOMjnc3JdDkKrryHY2bkYugWC1/zuUcgtDD
	 EQOYo2i5ET6MaeworPUMbY950MjZolmeDQWRJqZevzu+ppMouoqFX7IOs3wqKksK9M
	 l+fIIeZxSdCr/gfExjOCrHHnv6TUNHZe+kPlQXEk=
Received: from [192.168.123.32] ([122.191.232.200])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2D1AB89E; Wed, 18 Nov 2026 23:11:17 +0800
X-QQ-mid: xmsmtpt1795014677t41psb5ip
Message-ID: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznT7OENJT9mJHfwgV0miw9IXUfpRm2kJzFaCZLdrc8pUU5HoST3r
	 FwUWA8bq1iCc9BxI5OuH9gzoXFVJ39oulfgD3me9f6/0pTlCXD3mPrI8CviNxjSYnr02EHueMPWy
	 JmB2vyearJXsH5BUrcZqeb1jM9hZ7iJvIMjeap3WW9YdN8+L1P7hzKFmXAm/MvB08Y6Mty25lhY/
	 W1ZsPLbxk+vwC0NWPE5Ifw4eZQqht9u7+wB69If88CSKK305o9SJr3m8wzgWQ5eITnCq84e2EufY
	 y8iFPKWihfM2q1YO02sAChSUxJKotGXT+6FzaQJnhLfrPh1YqJLefxmJrTgMr7lo9HF7dF48D0SU
	 /Yen5vz4NudfIw5VAKfIN1ftW1MForkHkjjfmhg9VKpgBqCGITK5gYEcT9s1i1DfuweF6dpBpGKm
	 +gKbQpTQfOEJEvQMxOZVp4UPYKwtp7Od20FtG1jdXZsAK8R66zbFHyNvBOee4uhDumhHlhuhLqwd
	 kxKu3c12Su1GnRBPL+cW6EF3OAK4pvVvNxgUPcDFRg45UiI246kRErTanCUfXFebK1WF9eyvKz43
	 kMqu4jsCHXK7b3WKW6uQAGM+G3aHPo1IqN7VYRaBxmdepW8Zzx1i53CfEG3YIqMQCbjehtrq/USc
	 qePyPyHcKbdMk8G03NqCgdKZytHGgTBm2v9I5DCryad2lDGZP+7OnB3S35HRjZRxFPg6Rv5Org4Z
	 ZrMY5j8AYWDMS9BfNoNDSBnpvbwX+4r+Z8dkGobASIlA1h+by0zTW78+2YPXIgthvWUBsSUQziKT
	 eaxKKxPAdEATt//E20Lev8Tmb79fi6wJ0SeOlKW09CVzNj7stTvGZ0iHEyVxzM0Hqx3qeDvwwqcm
	 vv6+YRjVuW3Ae4eP2614kxKrwGTEGaL3fqR2rVZoKO0sjgn9KJ4xaHNExaHfhAiTYX4dPpHmLTB0
	 00y8xXP7ApIXnsGx2nX8TEjgc7neVbZXNUXDY85zCCMx/xIieBkwFN+QEuJ5BZGEoHVTujcpdjZN
	 X9Y1mpmLlYbg5w0KAWCkz1ydNbXWVfEPYts8Cu2w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: NanamiKite <nanami@yosoro.hk>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: cm32181: Add support for CM32183
Date: Wed, 18 Nov 2026 23:11:00 +0800
X-OQ-MSGID: <179501466033.5141.3504103739686378292@yosoro.hk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On the H3C MegaBook 14, the ACPI CPLM3218:00 node declares a Capella
CM32183 ambient light sensor (CPM0 device ID 0x7db7 / 32183) at I2C
address 0x29. Reading CM32181_REG_ADDR_ID (0x07) returns 0xc383, with
chip ID 0x83 in the lower byte, causing cm32181_reg_init() to fail with
-ENODEV.

The CM32183 uses the same register layout and ACPI CPM0/CPM1 tables as
the CM32181 and CM32182. Add chip ID 0x83 to cm32181_reg_init().

Cc: stable@vger.kernel.org
Signed-off-by: NanamiKite <nanami@yosoro.hk>
---
 drivers/iio/light/cm32181.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b32a940..aaf1af3 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -200,6 +200,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 		break;
 	case 0x81: /* CM32181 */
 	case 0x82: /* CM32182, fully compat. with CM32181 */
+	case 0x83: /* CM32183, fully compat. with CM32181 */
 		cm32181->num_als_it = ARRAY_SIZE(cm32181_als_it_bits);
 		cm32181->als_it_bits = cm32181_als_it_bits;
 		cm32181->als_it_values = cm32181_als_it_values;
-- 
2.56.1

