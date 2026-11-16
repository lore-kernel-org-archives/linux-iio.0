Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847205;
	b=MbX3INhpHJ1iwCGr6cmzMqEYX+LK7w4xKUO8TWWbqI/dK3s2RIdKBHDXP0j9xk6EKNz4
	 LLRuzOcFJ1XdpKJklVevXdwxuDtrQMFbXLSzMPhTNdRcmsFAXAc8GXWTGaygYkVrnP1EV
	 /jDEOnY7nXH7mMOeRQoGZN9Qrj8DuxjcBXl5Vf8l1+azlwTB2A9/ojvFHiYEn+2crEChn
	 +v5Up4e5mX8oxAMtNt0qZJXMCQdebQQVOVtlJMjFC9wniHbw8aGwlNZWKrHCzcr5Db4uR
	 PyzJF01P8Aj4Ef7Ysrjq7QhhBgDXFbP/cYGAFsd/t+XeHCMDTEg0xr21kJLJnXnmCCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847205;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=REjP0HT7txiVIfX/i0cKILYELpfwHlGOMTLlaGUs6Tg=;
	b=h6HDpctMV1Vzu2g7ETBfpPwAIEVXjJuvfZcQrUWy8zppZzywD24VvxsNs0GTjj7me+sn
	 keMvDQxvNR+Tl8NzRBYORnOwfGyG5Zr2obyIUEu0W+zknOghpM0CNI5/CM33bAHQoNCHQ
	 mma5iRWaGw/nclbpONSxz1xaDdKtxOgVSHcDRg0TTFggqjGucl/DF79npQtwYQf8o7V2n
	 7GIGSlVxKzlddk+KSyDTAH4yy/t0Zh8rnOexD/VLQb6jvkBk6lSOD54ZkMns1fyiKH1Ek
	 GAUxbh93u0UwynwOZoFqmkDlayqYvPh/HCJzKMsuu6FNLqVFn+kAfUSGIj/8ce+8kyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3b1JTEg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5F606A329;
	Mon, 16 Nov 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3b1JTEg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847204;
	b=yn3S/DgJXEC4oiIa03CiQ1nrj3A6NyYJQL4/oXIKM41/3/95uAveWO6e759kD/mdEasb
	 UGcirNklzoSbZwc20WI1nUKtw33updwasQcF/De0NFrl7NEVr1K8Y5hdMmgGgLKBxPR85
	 d3O+c0945CaYULqGhOMJg7YU6tOU6KAUbAvaeYbzVvtVXNMnCLTBlaRXd4KDZdE4XiaNA
	 UwjCqHUdmaLSBUWm+vN05Vtf5prRd5zcsdt46S22kM7IOzY+aAFYhGeoKVacExzhn0B1j
	 Amh8YwhdAToYhlL2l+9euHYE/YlMFp5gbzkg0I7UNdJlzbpzjs6VdPXBHmQx5gBOFGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847204;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=REjP0HT7txiVIfX/i0cKILYELpfwHlGOMTLlaGUs6Tg=;
	b=wuRNyITw/hScHp95yb2eilQaMaGheIMh7VyofBIdjzutDIubGxAYaS0At5Pf6BKhwgEA
	 QUlkv42LOBKJDtozvY7XZ9o4sLCQsUYTmZwMJvqGTaQcAaodQlTSA+5KVF9fiQB6a6Kb6
	 CAQGcFmC7tDQtL/FYqtS5Mn71lWlJoIVEpcolwYOe0lgmuh/08pbRzjDPscGjPXhBuUt6
	 KjvPcSltjKAO2d60LlEdSYX0PTGSZkrPNp5pQj1A9gjNM8Z6DnZKDKi2m4TDs7EQDulxy
	 0BbIRfQtcBFd856TEo9MUZ4CUVzE3OZvqt5Cp6ul+QH/LLhOI9ct5m9P+qpvpbCHWyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C3511F000C4;
	Mon, 16 Nov 2026 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847204;
	bh=REjP0HT7txiVIfX/i0cKILYELpfwHlGOMTLlaGUs6Tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=V3b1JTEgkzDw1YrWFE3zsizg0wUTvzNziNqbvZYrSjrzZVlrjCgyl+lrWtr3eeqSE
	 8VFW3ILXx72sNuduw0g5ruYCbgq+9alPdrhq+Fk0hfVi4TvBBOY9XlBhGTuMYjekBB
	 7qB7cZdAKsNs88jUcMnv6qBOaqWJ+5AO4tOM613IL6XudGzP058I31OG2GjsHOfe/T
	 J2Lx03ivLzjWa2+ybgXSNDCEhkFfK7MFJ/RIY+KxcesWm7/XVzxMbxTa7N0K+cOdXt
	 EAI8FeDFJalzAfVDSyqiOPlwS1J/z4MdH0A4cdx7fy6IE2eQiKIq+t0i9MdSt9R5Jc
	 e8pvrjbIcU5Cg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 80B504A53A;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:40:01 +0000
Subject: [PATCH v4 09/12] iio: frequency: ad9910: support drctl control
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-ad9910-backend-support-v4-9-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=10167;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Uh6LOSz2rVbPfLSEzRGsXLnUNV3d/JJ+O+DX7LQg3Hs=;
 b=XMyLfVwvDySqvN0zDbOS2x0cKoD4XvFgOrZ17Jd+EX1Zk6q4Rr9VdXSepbnp+sDeBdzmRTDQc
 WObQjpCNTj0AUU2qmBXaNkC9sRwDWwAQOrBtoxumYQHd2yGXXqUKEBg
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The DRCTL pin controls the slope direction of the AD9910 digital ramp
generator (DRG). When dwell is enabled at a ramp limit, the DRG holds
that limit until the next DRCTL transition, so the sweep pattern is
defined by the waveform applied to that pin, which can be generated by
a PWM.

Get the optional "drctl" PWM and expose the integration_time attribute
in the DRG ramp up and ramp down channels, which sets the time interval
assigned to each ramp direction while the sweep parameter is accumulating.

The DRCTL waveform is described with the PWM waveform API, using the duty
offset when DRCTL needs to start low. The PWM is disabled when the
resulting period is zero. The waveform is rounded by the PWM provider
before being applied, so that integration_time reports the intervals
achieved by it. Writing to integration_time fails with -EOPNOTSUPP when
no DRCTL PWM is available. As the waveform API has no stubs, the driver
now depends on PWM.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/Kconfig  |   1 +
 drivers/iio/frequency/ad9910.c | 148 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index f7f5c3cce005..591476f23ace 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -29,6 +29,7 @@ config AD9910
 	tristate "Analog Devices AD9910 Direct Digital Synthesizer"
 	depends on SPI
 	depends on GPIOLIB
+	depends on PWM
 	select CRC32
 	select FW_LOADER
 	select FW_UPLOAD
diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index d30ebdc0e0b0..daa77093e2e4 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
@@ -324,12 +325,16 @@ union ad9910_reg {
 struct ad9910_state {
 	struct spi_device *spi;
 	struct clk *refclk;
+	struct pwm_device *drctl_pwm;
 	struct fw_upload *ram_fwu;
 
 	struct gpio_desc *gpio_pwdown;
 	struct gpio_desc *gpio_update;
 	struct gpio_descs *gpio_profile;
 
+	s64 ramp_up_time_ns;
+	s64 ramp_down_time_ns;
+
 	/* cached registers */
 	union ad9910_reg reg[AD9910_REG_NUM_CACHED];
 
@@ -609,6 +614,58 @@ static int ad9910_sw_powerdown_set(struct ad9910_state *st, bool enable)
 				   AD9910_CFR1_SW1_POWER_DOWN_MSK, 0, true);
 }
 
+static int ad9910_drctl_sync(struct ad9910_state *st)
+{
+	struct pwm_waveform wf = { };
+	bool ndh, ndl;
+	int ret;
+
+	if (!st->drctl_pwm)
+		return 0;
+
+	ndh = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_HIGH_MSK,
+			st->reg[AD9910_REG_CFR2].val32);
+	ndl = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_LOW_MSK,
+			st->reg[AD9910_REG_CFR2].val32);
+
+	if (!ndh && !ndl) {
+		wf.period_length_ns = st->ramp_up_time_ns + st->ramp_down_time_ns;
+		wf.duty_length_ns = st->ramp_up_time_ns;
+	} else if (!ndh) {
+		/* DRCTL low on the first half, so that it ramps down first */
+		wf.period_length_ns = st->ramp_down_time_ns;
+		wf.duty_offset_ns = st->ramp_down_time_ns / 2;
+		wf.duty_length_ns = wf.period_length_ns - wf.duty_offset_ns;
+	} else if (!ndl) {
+		wf.period_length_ns = st->ramp_up_time_ns;
+		wf.duty_length_ns = st->ramp_up_time_ns / 2;
+	} else {
+		wf.period_length_ns = st->ramp_up_time_ns + st->ramp_down_time_ns;
+	}
+
+	/* a zero period disables the PWM, nothing to round */
+	if (wf.period_length_ns) {
+		ret = pwm_round_waveform_might_sleep(st->drctl_pwm, &wf);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = pwm_set_waveform_might_sleep(st->drctl_pwm, &wf, false);
+	if (ret)
+		return ret;
+
+	if (!ndh && !ndl) {
+		st->ramp_up_time_ns = wf.duty_length_ns;
+		st->ramp_down_time_ns = wf.period_length_ns - wf.duty_length_ns;
+	} else if (!ndh) {
+		st->ramp_down_time_ns = wf.period_length_ns;
+	} else if (!ndl) {
+		st->ramp_up_time_ns = wf.period_length_ns;
+	}
+
+	return 0;
+}
+
 static ssize_t ad9910_ext_info_read(struct iio_dev *indio_dev,
 				    uintptr_t private,
 				    const struct iio_chan_spec *chan,
@@ -675,6 +732,13 @@ static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 		}
+
+		/*
+		 * DRCTL waveform depends on the dwell configuration, but the
+		 * previous integration time values may not suit the new
+		 * waveform, which should not prevent dwell_en from changing.
+		 */
+		ad9910_drctl_sync(st);
 		break;
 	default:
 		return -EINVAL;
@@ -1054,7 +1118,8 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.channel = AD9910_CHANNEL_DRG_RAMP_UP,
 		.address = AD9910_CHAN_IDX_DRG_FREQ_RAMP_UP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_FREQ],
 	},
@@ -1065,7 +1130,8 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.channel = AD9910_CHANNEL_DRG_RAMP_DOWN,
 		.address = AD9910_CHAN_IDX_DRG_FREQ_RAMP_DOWN,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_FREQ],
 	},
@@ -1076,7 +1142,8 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.channel = AD9910_CHANNEL_DRG_RAMP_UP,
 		.address = AD9910_CHAN_IDX_DRG_PHASE_RAMP_UP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_PHASE],
 	},
@@ -1087,7 +1154,8 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.channel = AD9910_CHANNEL_DRG_RAMP_DOWN,
 		.address = AD9910_CHAN_IDX_DRG_PHASE_RAMP_DOWN,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_PHASE],
 	},
@@ -1098,7 +1166,8 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.channel = AD9910_CHANNEL_DRG_RAMP_UP,
 		.address = AD9910_CHAN_IDX_DRG_AMP_RAMP_UP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_AMP],
 	},
@@ -1109,7 +1178,8 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.channel = AD9910_CHANNEL_DRG_RAMP_DOWN,
 		.address = AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_AMP],
 	},
@@ -1337,6 +1407,17 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_INT_TIME:
+		switch (chan->channel) {
+		case AD9910_CHANNEL_DRG_RAMP_UP:
+			iio_val_s64_decompose(st->ramp_up_time_ns, val, val2);
+			return IIO_VAL_DECIMAL64_NANO;
+		case AD9910_CHANNEL_DRG_RAMP_DOWN:
+			iio_val_s64_decompose(st->ramp_down_time_ns, val, val2);
+			return IIO_VAL_DECIMAL64_NANO;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1637,6 +1718,34 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	}
+	case IIO_CHAN_INFO_INT_TIME: {
+		s64 val64 = iio_val_s64_compose(val, val2);
+		s64 *time_ns, prev_ns;
+
+		if (!st->drctl_pwm)
+			return -EOPNOTSUPP;
+		if (val64 < 0)
+			return -EINVAL;
+
+		switch (chan->channel) {
+		case AD9910_CHANNEL_DRG_RAMP_UP:
+			time_ns = &st->ramp_up_time_ns;
+			break;
+		case AD9910_CHANNEL_DRG_RAMP_DOWN:
+			time_ns = &st->ramp_down_time_ns;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		prev_ns = *time_ns;
+		*time_ns = val64;
+		ret = ad9910_drctl_sync(st);
+		if (ret)
+			*time_ns = prev_ns;
+
+		return ret;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1671,6 +1780,8 @@ static int ad9910_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		return IIO_VAL_DECIMAL64_MICRO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_DECIMAL64_NANO;
 	default:
 		return -EINVAL;
 	}
@@ -1958,6 +2069,11 @@ static void ad9910_sw_powerdown_action(void *data)
 	ad9910_sw_powerdown_set(data, true);
 }
 
+static void ad9910_drctl_disable_action(void *data)
+{
+	pwm_disable(data);
+}
+
 static void ad9910_hw_powerdown_action(void *data)
 {
 	struct ad9910_state *st = data;
@@ -2249,6 +2365,26 @@ static int ad9910_probe(struct spi_device *spi)
 
 	fsleep(AD9910_WAKEUP_DELAY_us);
 
+	/*
+	 * DRCTL is the only PWM used, so it is looked up by index. A named
+	 * lookup would fail with -EINVAL when pwm-names is absent, preventing
+	 * the optional handling below.
+	 */
+	st->drctl_pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->drctl_pwm)) {
+		ret = PTR_ERR(st->drctl_pwm);
+		if (ret != -ENOENT && ret != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(st->drctl_pwm),
+					     "failed to get drctl pwm\n");
+		st->drctl_pwm = NULL;
+	} else {
+		ret = devm_add_action_or_reset(dev, ad9910_drctl_disable_action,
+					       st->drctl_pwm);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to add drctl disable action\n");
+	}
+
 	ret = ad9910_parse_fw(st);
 	if (ret)
 		return ret;

-- 
2.43.0


