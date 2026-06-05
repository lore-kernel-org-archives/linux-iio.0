Received: from outbound1.mail.transip.nl (outbound1.mail.transip.nl [149.210.149.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9E378D9C;
	Fri,  5 Jun 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.210.149.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654134; cv=none; b=uWUZ/k8AA7Ee7ZMIf6Ki39Xq0IkQIiEq4wsBPSH6MGL9vOR4OI4hlIz2n7Hmksi6K+HKvZPbQI6Wu7iPPyT6Hb19KovpqKQ8FS9mOSfC8BwsxmJNdYNCHOJrftGfSHNJGiEvZQEsSOzM2PORzOsWFF88i1xKA+mnJqVsB/lMrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654134; c=relaxed/simple;
	bh=vIJDzY22/pR5PVFHnxAxJReqIhW7CHx+PE8fszsXqVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hriyuNiJnn71v686QbyuBRLH141MejwNbF5oork4/2avCYsEDVZaOOAQzZ3Y0R3RcoLe6BlsAyECuTcDdohs2TF8qkeHE13kmxVf/KWDNZmItz4r3hZJYzLUy0AxI/qtgYo/uw7LowfvHf6F//6sppOX9rRCY5F4sky2dJ3zoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=C5oTZjrc; arc=none smtp.client-ip=149.210.149.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="C5oTZjrc"
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound1.mail.transip.nl (Postfix) with ESMTP id 4gWxwY4SbvzRj3L;
	Fri,  5 Jun 2026 12:08:45 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4gWxwX6rLzz3R3p02;
	Fri,  5 Jun 2026 12:08:44 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: jic23@kernel.org,
	linusw@kernel.org,
	denis.ciocca@st.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	maudspierings@gocontroll.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 1/3] iio: common: st_sensors: honour channel endianness in read_axis_data
Date: Fri,  5 Jun 2026 12:08:41 +0200
Message-ID: <0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780652883.git.github.com@herrie.org>
References: <cover.1780652883.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780654125; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=u8xxJRCo95FdjbzXYIN6cwNdNtoDj6gaprfSMe/H9M0=;
 b=C5oTZjrcmM3BRd4UrxRVd3qRPJgM5+HscVMm6OIAiqcNP5YPpOsn1sG547GpnVGSxrah3Y
 nL9abxNVm9bjGn00YNccAgpcd7qyP7rfJhxUyZMUF3V6yqxp4mWg5ugxBNRZZsvhVk2U28
 mhyOhfnLqGJ9UAFr4WSCX0J2PEPdbzwZamZje3Kd5bozUFEZnpTemc6Ab1JG/ux/YufeF9
 xXjfLQ/rpITAZAePfvOGEk/cmrBHJfjinAJPVQglnYQfH0DtU4TSu/Q+6N16wMxMCAW3CN
 yzCQ6JZIqAuF4sxAIpflI2jqulBxqd8x3FC9apGuB7IvmaCc5/7cs3ASPEKjAA==
X-Report-Abuse-To: abuse@transip.nl

st_sensors_read_axis_data() unconditionally decoded multi-byte
results with get_unaligned_le16() / get_unaligned_le24() regardless
of the channel's declared scan_type.endianness.

For every ST sensor that has used this helper since it was introduced
this happened to be fine because the ST IMU/accel/gyro/pressure
families publish their data registers as little-endian and the
channel specs in those drivers declare IIO_LE accordingly.

The LSM303DLH magnetometer however publishes its X/Y/Z output as a
pair of big-endian bytes (the H register sits at the lower address,
0x03/0x05/0x07, and the L register immediately after), and its
channel specs in st_magn_core.c correctly declare IIO_BE -- but
read_axis_data() ignored that and decoded as little-endian, swapping
the high and low bytes of every magnetometer sample.

The bug is most visible on a stationary chip: in earth's field the
true X reading is small and the high byte sits at 0x00, so swapping
the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
= 240). Y and Z still appear "to vary" because their magnitudes are
larger and the noise in the low byte produces big swings in the
swapped high byte:

  before (chip flat, sysfs in_magn_*_raw):
      X=240 (stuck), Y= 12032..23296, Z=-16128..-9728

  after (direct i2c-dev big-endian decode, same chip same orientation):
      X≈-4096, Y≈210, Z≈80     (sensible values reflecting earth's
                                ambient field at low gauss range)

Fix read_axis_data() to dispatch on ch->scan_type.endianness and
call get_unaligned_be16() / get_unaligned_be24() when the channel
declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
st_pressure, st_lsm6dsx and others) are unaffected because their
channel specs already declare IIO_LE and the LE path is unchanged.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dbc5e16fbde4..84bce1539908 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -508,12 +508,21 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	if (err < 0)
 		return err;
 
-	if (byte_for_channel == 1)
+	if (byte_for_channel == 1) {
 		*data = (s8)*outdata;
-	else if (byte_for_channel == 2)
-		*data = (s16)get_unaligned_le16(outdata);
-	else if (byte_for_channel == 3)
-		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
+	} else if (byte_for_channel == 2) {
+		if (ch->scan_type.endianness == IIO_BE)
+			*data = (s16)get_unaligned_be16(outdata);
+		else
+			*data = (s16)get_unaligned_le16(outdata);
+	} else if (byte_for_channel == 3) {
+		if (ch->scan_type.endianness == IIO_BE)
+			*data = (s32)sign_extend32(get_unaligned_be24(outdata),
+						   23);
+		else
+			*data = (s32)sign_extend32(get_unaligned_le24(outdata),
+						   23);
+	}
 
 	return 0;
 }
-- 
2.43.0

