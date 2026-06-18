Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AD3403F9
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814679; cv=none; b=lP8r1FokLc0WJu3qgW2NUffiDAZpo2QIox6+EH3fbZf0sxUT8HLzWcuuSKNmFw1ANCjo5mAMjcd6DARw9gVuafZYqvLxhbg728Pdy/BdREqs0sAD6VyZOL5WpOC82sbC8W+rYYb1HHINLLucPjaQPz9WGUsT9aNkJ17QRKZSazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814679; c=relaxed/simple;
	bh=HLxQCCXxvKkwoegsbUnC3g4wlzqBB87zcGLg24R2AW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMHfWSRR0JkwmzHglvby1vY6t92Sf0k1TlQAAuOsWXfAL4Dh+nZkLLQtwQ3+N2yBUyt00rgR2EoIWaratCo+euFyISeop4hs5QIExtdrVqH3xKdsYJSpbbLswDGC1sh4j4677qZ5MMPvOP3Ur4auk7KPR7hw+YibjdGprFhKYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9i66YWd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cKDgJ9Kr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9i66YWd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cKDgJ9Kr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIfcTR2079945
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 20:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mMV94ArRUWNb5oU3/kS47SDy5ZbaBXLZRnnNKRvZXFA=; b=A9i66YWdpU6YBRKd
	Y/MBdL3leGrrJahi74KTM4KDUukQ+j5qURMvDHv/h26fAMH3YQ7DGji15TAnMGwL
	USEPfEP8AD8iQcYvd1iG1lfmSmz7UW+zAngX+q6y2E0CUnCSI7j/tqtfhJrqkhqe
	Bb7YKc+I5KSThSi349qRKDQodq8XXrVZwF8jlfC8noswCAbuAmfFSXFNt6pILgF2
	eX7GqmBqg+WDX9b4uCvVGCkgfKaMMi1FrJfZJo0n6j3P5s0uMfYxkHKqzunR9kjq
	QH8VKdbeCj2Uku3j8+w1XmjnU3du0rg0dmLmftvJ50lp7ioEz2fD83urICNDRRJs
	2WsO5Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp670gyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 20:31:17 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so576225137.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781814676; x=1782419476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMV94ArRUWNb5oU3/kS47SDy5ZbaBXLZRnnNKRvZXFA=;
        b=cKDgJ9KrjXfgYkuAz0ahLGqygx6y96tTuM5gD3C6jnlyEPsEzOJG6rZPFM8HnOjgUr
         mUUny6jmwB4C/3MTNm+teD5GdMiZP4WuTn4qqsJ5IwzrdGdmc1LMEd6BrdJug9uYUOH5
         UjwoYLe660iDTEj3y+WbBF7B1rOWE/xxbvbgUh+iJNROoAE4T1ZJDGBbAOWbP0g0TKgS
         TqF2WQuS+7G1kv8+QSLOrPaiarGne3IBo0DlY8/mkZYSMvM0Eu9mMTxPIJznjIbl4ekn
         g6vBVFmRWSKHwZr6T7cU8YN0opsqUwy6g/ine6B3F6pss1S7DEZRDUXbkiD0E2sLaYvZ
         V4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814676; x=1782419476;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMV94ArRUWNb5oU3/kS47SDy5ZbaBXLZRnnNKRvZXFA=;
        b=NXSD13WX6NAvCpqBQVmwnUBWZL1BXmqQ6bt/7nKdR0WQZOyUwssr9WrRPIGVi48/u5
         7rPizSFinOT8Y6+jILNXHx94ZOAtqBZuPLejU31ohjGqIy1MSFCaDx/rvNL58xiPriht
         03SnFw/nEs8zFLCAc+PjeNS06k5GWg/kq8zofU3Fyiw00Vu+pZ5PIBaD+3zVePz8UIx2
         Runkf+lcFu9PnTdIsFjxLF0hAO65turFX49Du0Or0k6+p5QLZHojuftR5dA1xHxceViy
         H32oCJOP5g4/hSOJucT8gV+vibe41KMoX9F90W0gM0kG+JADkEcJLFRvwpwgKE9UDf1t
         NNRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K+ypndhWzp6N5zufVpzJcwowuZdcbdlI8lM74NvjLhxJHxD8VFROpOhL6T93HuwYN3bSlF7+dciA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPpk+7Edv/xBoqJM7aHgj7G32TKoTCQBrDndFI64hwe/niYmd
	LM9JBmQSVMGf8RxKhG+krHPuKEXAfQpn/ddavSP7TkO8Pnt7AEKxn4Fxso4y1Nfr4K/Qvve4/R8
	FeVykZe7Utcn5C61la0tOlIgwcEEG0uULb4V/e76tUUkPqlz/iNgCQPBmxEUiULU=
X-Gm-Gg: AfdE7cl86qbMxz/X+MPQrxsxjeonRxhBUUr1Ofn8PzzhSmfpBEwkcQX+/e+PNIPRtLI
	uNl4lgPMRXsZZcpoGkYBw0a0JNHOjl8PI1Hamp2tSCuvQNOMDmSMVez5VZZK0Ti3WuqyAx1WbUC
	StFxLc50voYgI10SWfp5eC8keEZqNsyMTo+QcgXbri7aJyfBP2Ef4kEkwCoR6DWsRVfspVlEOw5
	IflhfeOdHcW0njDNVvl1b5h3naljDQPN4f2EMBeLYyk3p1vHJZGHcR8+cpXzh+6XJ6HVL7uIXAi
	lal5rerzf14DkO+z6b722Fn5Drx4zrjKyK3BXtvdsVVdPn1i5qDRjRKd5XFHkEczveBxq20QSm+
	lfm1boclcTruwXAH77fG+QnFbFAxo/u5YJJND4sV6/CjEvEZVEJIiZROyeoIUrWRz+f7QhOZt1q
	BdX60Uh1d/Htv+wGex7wQc3LRvo6Q/liH98IUBxDJ5JH5EcUWXQ8VSZLT6yFurUN4dmXnNmLCvG
	e+ZRw==
X-Received: by 2002:a05:6102:448b:b0:650:aa33:5dd7 with SMTP id ada2fe7eead31-72a01884599mr1095683137.2.1781814676210;
        Thu, 18 Jun 2026 13:31:16 -0700 (PDT)
X-Received: by 2002:a05:6102:448b:b0:650:aa33:5dd7 with SMTP id ada2fe7eead31-72a01884599mr1095628137.2.1781814675743;
        Thu, 18 Jun 2026 13:31:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0a8490b104sm2351966b.14.2026.06.18.13.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:31:14 -0700 (PDT)
Message-ID: <8c2a4ae3-95cc-489a-a7a4-90a3ee2597e9@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] firmware: arm_scmi: Ensure automatic module
 loading
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 11PlblUBSRpIgFSw-HD_LO2u8k76j9tJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NyBTYWx0ZWRfX36EqLO9UaDn5
 W3+B9jdQmGlQKsMd+x9p/OXdAlqETqKW1gJr5BJ5fPdEBMxkglw9Qw8Kwo7GIpIMD8uD9mRqknC
 ZnORW8bJghbOu1uJDqNE04b/D1BTJFBwcWA8ZjpgjtDbn9/xRB1RUv34UsiVBcy6ruyTb+q2wD8
 L9K3zZF0kObKjeykOgFUoWS2JYE9FocHKoS/XvYCRAcsSg6jYh6uUf9FvdWHGfx6KsVJoy/mnP7
 gKsqLLfgG+rZzygvhu5RK6rt1IJjwKtas0WFTlqQs2R/1KwCkymm8pt/R0J57z+XGIIO5E0JufH
 fUFxOzEGrYa+o/bHX867y+3ah8OrKhKdYgoEVpDpcofpo1n+vTIOfVlKdTRdhdQUyUTj+mNMDuE
 A6fASM0YWMvCxZeEaGyyb83sTdtPL7uOhkyEev21nWKMSgRX13DBR8cBGne3W3eXksQTMal2H9T
 j4/Q7Bmen5R50SAtlEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NyBTYWx0ZWRfX/P5HYYoJ2r5t
 qr35fPl8oDR8EyQiVb8ObpJzPbYoj+dHBVHDi9k+X8XmJaC08pWB12UxdOGqqTQDKLE0w9s1ohu
 x+1YkwxcGR6hx9h+TBi7zJSzRBD1j+Y=
X-Proofpoint-GUID: 11PlblUBSRpIgFSw-HD_LO2u8k76j9tJ
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a345595 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=IpJZQVW2AAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=8AirrxEcAAAA:8 a=pGLkceISAAAA:8
 a=_jlGtV7tAAAA:8 a=1XWaLZrsAAAA:8 a=gAnH3GRIAAAA:8 a=P-IC7800AAAA:8
 a=JfrnYn6hAAAA:8 a=5KGQkzpS6Bu23flkvY0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=cvBusfyB2V15izCimMoJ:22 a=ST-jHhOKWsTCqRlWije3:22
 a=nlm17XC03S6CtCLSeiRr:22 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180187

Hi,

On 18-Jun-26 17:56, Bjorn Andersson wrote:
> SCMI drivers such as the Arm SCMI CPUfreq driver are allowed to built as
> modules, but they are then not automatically loaded. Rework the SCMI
> device table alias support to make modpost consume the information from
> MODULE_DEVICE_TABLE(scmi, ...) and allow drivers to be loaded based on
> this information, if known. Also add a protocol-based alias to also
> trigger driver loading when only the SCMI protocol id is known.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

So I just gave this a test spin and unfortunately it does not work.

The problem with Fedora's kernel-config / setup is that the
request_module() from patch 2/2 runs from the initramfs, but
the scmi_cpufreq module is only available in the rootfs.

It does work if I explictly add the scmi_cpufreq module to
the initramfs, then it does get autoloaded.

We really need some place to put a uevent sysfs attr which then
gets replayed when udev is restarted from the rootfs and then
re-reads all the uevent files as part of its coldplug
enumeration.

I wonder if it is ok for a single uevent file to have
multiple MODALIAS= lines in there.

Regards,

Hans



> ---
> Changes in v2:
> - Use request_module_nowait()
> - Drop #include <linux/mod_devicetable.h> from scmi_protocol.h
> - Link to v1: https://patch.msgid.link/20260616-scmi-modalias-v1-0-662b8dd52ab2@oss.qualcomm.com
> 
> To: Sudeep Holla <sudeep.holla@kernel.org>
> To: Cristian Marussi <cristian.marussi@arm.com>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Nicolas Schier <nsc@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jyoti Bhayana <jbhayana@google.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: arm-scmi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> 
> ---
> Bjorn Andersson (2):
>       module: add SCMI device table alias support
>       firmware: arm_scmi: request modules for discovered protocols
> 
>  drivers/clk/clk-scmi.c                         |  1 +
>  drivers/cpufreq/scmi-cpufreq.c                 |  1 +
>  drivers/firmware/arm_scmi/bus.c                | 20 ++++++++++----------
>  drivers/firmware/arm_scmi/driver.c             |  3 +++
>  drivers/firmware/arm_scmi/scmi_power_control.c |  1 +
>  drivers/firmware/imx/sm-cpu.c                  |  1 +
>  drivers/firmware/imx/sm-lmm.c                  |  1 +
>  drivers/firmware/imx/sm-misc.c                 |  1 +
>  drivers/hwmon/scmi-hwmon.c                     |  1 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c     |  1 +
>  drivers/input/keyboard/imx-sm-bbm-key.c        |  1 +
>  drivers/pmdomain/arm/scmi_perf_domain.c        |  1 +
>  drivers/pmdomain/arm/scmi_pm_domain.c          |  1 +
>  drivers/powercap/arm_scmi_powercap.c           |  1 +
>  drivers/regulator/scmi-regulator.c             |  1 +
>  drivers/reset/reset-scmi.c                     |  1 +
>  drivers/rtc/rtc-imx-sm-bbm.c                   |  1 +
>  include/linux/mod_devicetable.h                | 12 ++++++++++++
>  include/linux/scmi_protocol.h                  |  5 +----
>  scripts/mod/devicetable-offsets.c              |  4 ++++
>  scripts/mod/file2alias.c                       | 13 +++++++++++++
>  21 files changed, 58 insertions(+), 14 deletions(-)
> ---
> base-commit: 8d6dbbbe3ba62de0a63e962ee004afb848c8e3ac
> change-id: 20260616-scmi-modalias-0f32421bd452
> 
> Best regards,
> --  
> Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> 

