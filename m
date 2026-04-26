Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A65389106;
	Sun, 26 Apr 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234496; cv=pass; b=dAHe07ePYJuYQJbFqE0h2KIrP6sHhAjwkuK85Ck0TjKi81ZykpuerYl32+w1qrjqukNQHoM/Uu0uDIz12RDSWulpi3fbhTYTe+96jWGz11vhLjhCuxLaTal9H91kepDd0RhgQ1Jl3GWlEs8V0foLTrhYMi4+WPyBonLIn8Z8J/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234496; c=relaxed/simple;
	bh=mltS0lNffyFe8OV7KjnOk1JbOoIpjoYboNePj7eHJBc=;
	h=From:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc:Date; b=jon8A7nyge8tcldZdOYIiMoEX05MqAGk3cLa/gRlg2xo7lX/ql5iIh8Me5yGYa9BgGLMCNMmmcKSJSrnLqLIeAG9Ed41Pa97hjqXWtG0F/2G6GOHKXQ5dQYSUjg3MPogudMKwLYWTtEyeiKNJe9SsJv2A1zWFsPGmkjmm1YHsKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=WATmwduW; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="WATmwduW"
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D1D59400B57;
	Sun, 26 Apr 2026 20:14:54 +0000 (UTC)
Received: from fr-int-smtpout13.hostinger.io (trex-green-8.trex.outbound.svc.cluster.local [100.96.8.215])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E1D91400B55;
	Sun, 26 Apr 2026 20:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777234494;
	b=wGXpRdoEIe1AykUFLOkYDS5zrLQdZgQoH+21wYSFs5D5oSdeMZz79QgzTubVyZsRjZbr54
	VNlwDTIEYlfoaRhsK2SbvfJ+ZB8zGaqqlDD6WZYeB1WuhxvtuXDE1yRZek7VhPDpDWisv2
	HBzlPzj71wJy/86jcX0JVtXHTWnWkvvkkd2Z0SZgfvMKNKxOSrsPDs9R57NWiLfpQ+QFp7
	EhyHq3WRPbf6yKmSTLcHoOcMJ3YhHRqhiPFRlBKfHv94i1ml0PWaMHLpEyMx8JmY+5Tjz+
	a+lzMT2KQ3+7qVl7lqcJ1utgQ+uQt3wy7IJRSZljw25bKydQKVIIIS0HIs0Atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777234494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7AYZI01aPJnMQhaQvHFyZtCblGlVMaOsDhrTfhnMqfo=;
	b=VzIaJeosq9kP+mmdGda+Kvq9eXUR8CCnDP0nMMkkPU9joYiZxSpx/tIbcyaKlAILx8w/Jh
	rVLW0bvUTYS2geQSPilQhrTLApOdgZj+CgEdnmNO1lc20nDtg8KXJlOkC9+TwVdHkaOgQf
	t4ohFx/hvEACqRE0Dbwp86Au3lmkEVyDOWwNjqjPnSfafktUch2qBzClzyLH1WUMpH86N+
	MjACL9if3mvfSf+Af+V6W6s10C+aT+5+39QxqnjY559XbtQgNdg7mfdQyfkxgWSfBVP8dS
	XUJIiizB2lfR/Ox4v5mwoSfc7Pk0LaVKjWxgVaLg1e+b2DPSMbMHiyoQWwyJxQ==
ARC-Authentication-Results: i=1;
	rspamd-b9d4fc544-8wftt;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Snatch-Interest: 4d3bf5f4144d266d_1777234494773_2366053198
X-MC-Loop-Signature: 1777234494773:3107256095
X-MC-Ingress-Time: 1777234494773
Received: from fr-int-smtpout13.hostinger.io (fr-int-smtpout13.hostinger.io
 [148.222.54.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.8.215 (trex/7.1.5);
	Sun, 26 Apr 2026 20:14:54 +0000
Received: from [172.17.0.2] (unknown [125.163.204.171])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4g3dGH07mQz10pB;
	Sun, 26 Apr 2026 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1777234490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AYZI01aPJnMQhaQvHFyZtCblGlVMaOsDhrTfhnMqfo=;
	b=WATmwduW3uNxdpcIPFVxfoPhEg8xpIfazWPkyd0GTlZTjYWVlBndMSD2GHixCxSMfRHKfB
	buQ+PPOcZKbk4RMPZ2lxAplP8uOXjE96/ghO1eNmj9mbfb2Fd/au+Zmo9G/VV093NkJgdk
	4Cw4Lsfj81Vh9ET4EXRbksE0JOI48Wj4fgVxWf6dRQ/wUQV3OVlVZPBg/wXkd9w7v8zCfX
	6gSSi7cUJccYqOPFQnJjB02eGiKizrLXgDtQeViYKQtzxTAklrNVdCk35xpE/6PqyG5D1F
	g9l9E8gSyzwZC+paQvghezG0PXo0eVMLCTzvhGHD6EPr47xmim6p/c5+Qc0QWw==
From: Antony Kurniawan Soemardi <linux@smankusors.com>
Subject: [PATCH v5 2/3] iio: adc: qcom-pm8xxx-xoadc: remove redundant error
 logs when reading values
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-pm8xxx-xoadc-label-v5-2-9e7b5a53ef99@smankusors.com>
References: <20260427-pm8xxx-xoadc-label-v5-0-9e7b5a53ef99@smankusors.com>
In-Reply-To: <20260427-pm8xxx-xoadc-label-v5-0-9e7b5a53ef99@smankusors.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777234478; l=1799;
 i=linux@smankusors.com; s=20250609; h=from:subject:message-id;
 bh=mltS0lNffyFe8OV7KjnOk1JbOoIpjoYboNePj7eHJBc=;
 b=NwDtpE+oxejwtv0rZ/bGymamwxOLwrJD+A0EhgPP6Z8r0+sLy4TiD9+DwLIKI2vqx20eeuexU
 rX8gzNvDAqtAe7zZq0pYWnTz044ec1A/ILE6mWzZ6UwV7bz6pHtNVHz
X-Developer-Key: i=linux@smankusors.com; a=ed25519;
 pk=65wTy06fJl2/h/EJwjr704YG+yjHFhZObJBWzzK+N00=
Date: Sun, 26 Apr 2026 20:14:46 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GMJaEfNK c=1 sm=1 tr=0 ts=69ee723a a=x8mjGQfUP7wLEdXozly9Ug==:117 a=x8mjGQfUP7wLEdXozly9Ug==:17 a=IkcTkHD0fZMA:10 a=EUspDBNiAAAA:8 a=wxLWbCv9AAAA:8 a=KgMSzCYp6QPDUwhpC-EA:9 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22
X-CM-Envelope: MS4xfNBzOTb0FpvGVVpqIbkLowTIGGoBnijnqc/fYbE8G5xz64OjxrUcEA4I33NKBWk23N046GFkfpB5heYr5ehvOcS/gOsuzfTGLeEhD883KFbfWgiwu8G6 aMV3jXEZ5WA6Qo9sVKPJuzq+wrNUkazY1juFbZFqfN3TY+bKCvS01WbFUOX5Wq1BcdDNqpj+v+7d6HDaWoa9dEJBNDuxHzS80kMwkhdh5Bu4OnTpLhIup7cd z58hxsYPonyS1xV1A5M3nYJiN57fNSN2ejKBJDoRVj1e88oJEsynyoE3qLXpyXLo7ozHF2rTUC9SV9icY6U+sb1R3c5/UBXt9drz/idKhQw9ar8X6XeIjtBp xsHUfiHUNyUZZDLS1S8ckerO7XQu7OBqXKFzvIOyGkAlrKPr2U+g5dpprBUohsjnuXqfK0M1GYnyKaZWwNxtfbpozQ/ysPgQZk4fw4kwzs+DPOxRkPmiAcC8 pu5RolayxxRDM2NPiH3Yk/WGqlD2UO6piDbp+r28M86CDWISa6Bj6t+ypWSowjjuL7LuvT4xM0JB4pN21+id0nykXLNrCPHfmdA2szMgTMkHFKq5mQ9YBinA Y31OZslsafzIXpXnrGHFfEZYEHlHAOMCCkiXQoFdP0kawWJSFj730udwnBsVpBk1tJnTyckjAZZfR/DhznYxmZqsKflqihfh71jFS+RoMOnSQAjQEr5nGsp0 0wovBl6g47E=
X-AuthUser: linux@smankusors.com

Drop dev_err() logging for -EINVAL and -ETIMEDOUT cases and rely on
return values to report errors, reducing unnecessary log noise.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 31f88cf7f7f1..89858e81c859 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -535,10 +535,8 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
 		goto unlock;
 
 	/* Next the interrupt occurs */
-	ret = wait_for_completion_timeout(&adc->complete,
-					  VADC_CONV_TIME_MAX_US);
-	if (!ret) {
-		dev_err(adc->dev, "conversion timed out\n");
+	if (!wait_for_completion_timeout(&adc->complete,
+					 VADC_CONV_TIME_MAX_US)) {
 		ret = -ETIMEDOUT;
 		goto unlock;
 	}
@@ -657,11 +655,8 @@ static int pm8xxx_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		ch = pm8xxx_get_channel(adc, chan->address);
-		if (!ch) {
-			dev_err(adc->dev, "no such channel %lu\n",
-				chan->address);
+		if (!ch)
 			return -EINVAL;
-		}
 		ret = pm8xxx_read_channel(adc, ch, &adc_code);
 		if (ret)
 			return ret;
@@ -677,11 +672,8 @@ static int pm8xxx_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
 		ch = pm8xxx_get_channel(adc, chan->address);
-		if (!ch) {
-			dev_err(adc->dev, "no such channel %lu\n",
-				chan->address);
+		if (!ch)
 			return -EINVAL;
-		}
 		ret = pm8xxx_read_channel(adc, ch, &adc_code);
 		if (ret)
 			return ret;

-- 
2.34.1

