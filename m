Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682353;
	b=vr/qgzHedxomh9v18WawsZ3gZArUouALlqNUD01V2LsYZKbb6X6KB7Tr2bgxTNyXzzVp
	 SNetzHaxyKGZX45MNgLeRbK05wwav7V5kc3LafjKmmNu7f/KY+rCbslz10TLztlVZVoJb
	 RfHcHAJfS/rpHt8K64W/c/+IDZzhrCdAFAVDMlhlKLwItk+FIwwjIoGXxAV/er9BFMrOh
	 i7Uu35IFjwFkzwO9YIYHhAh81yId+8U6a8JugSmCOthVVYp8yNs+s4jG8d1ju5pYsDLBU
	 FN0vF+Xf5RWZL2q8v7ZZL36CF12aVuOdOetwjNioPX/QPwB+dCXEJgXISBJM1yvQ++A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682353;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bKY/is6AhRtOF4CROF9s6PJ1wA3Cbs/0fe03oh4k6vM=;
	b=n/wfg7zM/CPL4C9VXzLhi8uq1LtzfmaHSoRJpYammvANtMEpt6MW7jnDYSv8uDltLDNO
	 3jZtUuwN1yRQZ2gmn1cjir3FxN4XEJ8SOZiRfbiXwgnOthlO901qIEd2+3jvL7yZ236CN
	 j6v0VyCgm9oM6XZlNQ5/30cvcs4d6w6FQtvN1FWDsC2eXlFyI7rGBidtHvY9WIV65JVzp
	 bEQMnpm5VjKWLjA84k6hYt+uerDPGUVrAExnfdsxs8LaS0uqdolyjig9rEczyCy01dwan
	 DqKpJBdlejswV2Nn9PY7kpgSPpzAKVTA4T0EEDj+Inpu8CPvmpyxbAWBDQg+nvrB5zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oitr2jY7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEA606D4C0;
	Thu, 22 Oct 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oitr2jY7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682351;
	b=10A2KMoVdjMW7uhQE3C9Qodv41aeJvUfKXuKV8KvuekX8TX6/jnklyPhgQXR5VyQzCLv
	 RUzNFXn1ewqn2kRS04Za8kKWIc+DAeWnO28iCcfApGbNg5tgJU8R8Vx3jqZWkro/oV8Vz
	 FGmVFnFgQnThEUCgDJkGCq1RegLgQTha2zfAGFQtkgiRBn3v+4C+atKtHmJvYJozOfn89
	 ZuNE+uAymJTbjWDl5c+kNwHFdciT4FMk5IqyHDHUTIy6MFxfZi+7iO8Aq78oJxf13W77d
	 k4dVq2zljcshAcqX6GasMgceFLDtQP686ioxsyHhm6zE3B57Dxy+nbN+jEyL4mEl56g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682351;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bKY/is6AhRtOF4CROF9s6PJ1wA3Cbs/0fe03oh4k6vM=;
	b=gkL2tlXJUkhLZPQQcwy0eO5YYt+Ris+fWC0lpz7WdI64Ix/qvLwsXId5CbTWf7Ggk7ky
	 f9LCfHwwt4Z+xvxoX+fzyiqhFLmsEulUZxQZAhfT1Fy9p9TGODnFv7lwWCtwGwGzm/drc
	 XP/XOZ2FmcBaoM9I5YAx6ojE1WFLslaoXI8uRQS3+SYQqg3hcuK3FivjKMr0MHt8l3Klt
	 OaJd1RlTHeRC7euU4unK1146lPoFTcsjU1dEUVl0RLw/ZMw+C6K51I2cVcDSbR9KSTJa1
	 v9NFSUziTVzX8uhTzeZjOjl6VIEsdZ4O3QKB40PjxPOzQaf3wpmw3nK4kuXbCu/LabQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7A75D1F031E5;
	Thu, 22 Oct 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682351;
	bh=bKY/is6AhRtOF4CROF9s6PJ1wA3Cbs/0fe03oh4k6vM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Oitr2jY70WC+tS40+akIbGFn/CEBrRnklik5rH5DArCu4DaZz63UZyZUlRUDnrYRZ
	 ov0GluiqtZr08GA2v2IKF0jp39qPxXXznbj0XhbnpiiaHbUVVzDPpZFR6Jw79Vm16Q
	 787nswks7jaJcVzpfNo9IKsucAQ4WNOK8ODimNQywtkzK5PHwR3T3pc4ISZcCHK2qJ
	 AV7gEL9RvwuBVk8q6k/VMikQZ0TWd1KM44g1kw6ojRXzRZNI4OA4wyWr+dEPlYphBr
	 HUJqToMdakjIDsWm722HtneAfGJb7ltG6zWUQ2Q1X0kophSFAKdH6+c1/+cICsa7Py
	 qECNeyuKOokLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AC71441E6A;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:07 -0300
Subject: [PATCH v2 09/10] iio: ABI: add integration_time for output
 channels
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
Message-Id: <20261022-ad9910-backend-support-v2-9-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=2039;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=snDH6M+COm79T6hMU2A4F2/Mb35rg85wpRy/sNJ/PXk=;
 b=AX9Y8IIo8DZzVnP9+O0i+ZiT0a9n/HEiHL+Tk6p7GgXlTRKLNRGwrRJgk9Wpu8L6KQfiwh72E
 qPMePHApTPKCFEdMPziIWkyDReC6FbugqiMF2dqSq4Hoev63XQrOKwY
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Document the integration_time attribute for output channels, which is
the time interval during which the output is generated by integrating
a quantity, such as its rate of change. It is the output counterpart of
the integration_time already defined for input channels.
Add entries for the altcurrent, frequency and phase channel types, which
are going to be used by the AD9910 DDS driver.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2b6f57041763..b09254a57438 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1744,6 +1744,23 @@ Description:
 		seconds. If shared across all channels of a given type,
 		<type>_integration_time is used.
 
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_integration_time
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_integration_time
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_integration_time
+KernelVersion:	7.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to get/set the integration time in
+		seconds of an output channel, i.e., the time interval during
+		which the output is generated by integrating (accumulating) a
+		quantity over time, such as the rate of change (roc) of the
+		channel. The output variation over this interval corresponds to
+		the integral of that quantity, which may be bounded by limits
+		configured through other channel attributes. The written value
+		may be adjusted to the nearest interval supported by the
+		hardware. If shared across all channels of a given type,
+		<type>_integration_time is used.
+
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_integration_time
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


