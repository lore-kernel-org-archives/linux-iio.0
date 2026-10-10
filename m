Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7335342510
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621776; cv=none; b=jRiLQh0Iq2hZTXsc8VQG6nBaWHgdUJAhZROcQxgSlSiFZKT25lbh3g/foUxUrM8balT+sVejCxfao/UAzKs4xO5xqBpgJTzpE5mniqJ0WNR12cRUVk+66uT2NEkG3H8aiq04yqSSHVS4Pc6aYqyWIs1X9u5kkowWUOrP+hXSTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621776; c=relaxed/simple;
	bh=T0cHhk3sVg14STn5ch68EKKiVtS63d3OH+IINR9SoUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kw4BqvRG2qL443zzTcJhP1pVSVHaroSGgA0qKDZC+uN/8+akmW8DYy+XYzjqeB7fBWIrntq3uIKJWqqLTHWoO7jhx1MBTcF0obn3PXTgBwnWa/cAPEGQ5w9Dw5u0Px3jY27wAnZBVXMEZYhhHl6EJPXWtC/lvFRlMHqvslFpvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fo5lzCKR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U60NLG4u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fo5lzCKR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U60NLG4u"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69A3YYZe3723725
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 08:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqymoQ2HDibV8WA0yhfluVKdlQdB/7YbmVl1gD2ORD8=; b=Fo5lzCKR6ouvQqMF
	AfXvk7qHNy+UGr0uB/I75FzhO/oHguIgOagvJ50C1NXQUikQfyJk79H9vjFIlnjB
	bgTjhV8vSzS4dPkTiu8g6i4oO5GZS5Hbva9CkwhMzsCPgcJ3se2tzthEO1U0YM/h
	qqKO+KNKfG+Bwtqnb1VFRRoze4vVy6qBoY+WTKXije/fNbbTy3NigBrpI1x3+A0r
	uIlAHrfVf71v/5ji4yntBkpw+jq2Bhy0bKyGz9N8eUDWvzrEPHJpKe+wvJJZUPau
	BceKIvfkXsLXb5ZCrcR4QKdS/cROb9qNkdQ3r4GI9dt4fqy1ey8vUMAPPuUjd38K
	cYoPsA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk20jsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 08:42:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ce7a85f04so112375585a.0
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791621772; x=1792226572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IqymoQ2HDibV8WA0yhfluVKdlQdB/7YbmVl1gD2ORD8=;
        b=U60NLG4u3jcimbiOPlvSarsUzmhvlmXgWTlCnjWhoSzx88fR7emY9fIESym/zdGUq9
         TNqkL1VvcZpcVAOR2d75f+VHusG0uKzayhYghy0XhqAtPCcUVqxqlegihXsG0HXI6xyp
         qSW8SyjefBsBO27P6SuVQQuDa+hrf5kWcfDK+2AtBQVgNJzbFVqK050FmZ96UD5WkbZp
         Ml0T1i/PBshz87SgQX8AC6OWBuRoAaJRucuP+cLWifmRn0lagzyOrl/uufGfCP4uejlj
         3DWhGJt3gJfXxk2HiHSGYABaNDXmUoutJyX3nS99GpYu8bL3Mjb9AFmlXt+5QOAqh06n
         bVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621772; x=1792226572;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqymoQ2HDibV8WA0yhfluVKdlQdB/7YbmVl1gD2ORD8=;
        b=U2Df32/o8GnprmWEh+md2oQ3gOjl95F3azGMkV/azm5zJg33YT3FB8Hvs3an7oYJa+
         dkJfOxpzQAualG31VgaWEzhENlFTPEOdu7o5q9jeyCyQYNgAntsHJxHc6JL7KMezSPXE
         Sp58PZ7MeZBK7liavw9FCYMedSZG6TdU8Z1/a1IwIkGcK3A3jT30BKar1hAHgWMmUCvR
         8EiocTvFTq0gRU0N0nS67BPGhRar5AKzsBIOG/K3iVSfX0Hl+MlMt6x63ybBZ97W59JK
         Ol8HET5YpqJOy9OoThKWJB0lML0dvaBddt/uv9gxHsHA/3IhFg6JLdaelOeiejRVEc9h
         OeKQ==
X-Forwarded-Encrypted: i=1; AKwUvByfSdL69yNy8ClMTx6cxI2vzBWnYA6ptwV6ZqOccW1bAMwr3BFOWKy5J8oXSSrJnH48z6fvYTLrki0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs488VD+cN3nrL+ci2p/Vesz8eG+cCOlfILuciAT646eWDmwv8
	7xTIkILbm/eYNtoiDbwUO1HemoPfCdxL3ECKNCArc8nsA7kvBaOLu4TJR+5r7Vh4YT1E7UkLDF4
	PVik4pc+eLwsSfXPYIsySbjzzLkIRvYVwUElKW+Lz/QPkI03zUDhVQVZIsorLRNg=
X-Gm-Gg: AYBFou1DXc36CxxQA9kXG72RQ5OZiRVnHrsog2iQ1lB1Eiks78AevsPnNe2sfAKkCZv
	L8JQinM8ei1D40QBwvabYe7KG5+vIEmOotR1YWiPaLVHAUUvcUQ4PS336zOUexZrmeTRiE4i6ve
	g01mbdtu8JTplb1JPjXzJas0eb1SDHyvaeiHPr/x++kY/MuCMGzabnGxJIriJTeSkvKgdrd3oxp
	ghZ2hU7iTg5wBhlhEOi2fUS1JbtnDenV448U3+o5+uPUbQ+u4Fc4cZ8300AxxLxuj0M7JwHxrUd
	Z9TOk2IUGl1dcEw4PYKCBxdvGuXoOZQ0dtc4ATXmEhXgVhbo2adFApqZi/qfAcw1x89RM3cOiM1
	/4G3XJEpP8cPYvpbOW/KjEcNGyvspwwEVknz3oz/WrgLDz4t15KU=
X-Received: by 2002:a05:620a:4146:b0:93e:5929:f012 with SMTP id af79cd13be357-93ebd1bb215mr668129885a.18.1791621771784;
        Sat, 10 Oct 2026 01:42:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4146:b0:93e:5929:f012 with SMTP id af79cd13be357-93ebd1bb215mr668125985a.18.1791621771276;
        Sat, 10 Oct 2026 01:42:51 -0700 (PDT)
Received: from brgl-qcom.local (126.171.88.92.rev.sfr.net. [92.88.171.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm49065585e9.1.2026.10.10.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:42:50 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        linux-kernel@vger.kernel.org, Bryan O'Donoghue <bod@kernel.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Alex Elder <elder@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        David Lechner <dlechner@baylibre.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hadar Gat <hadar.gat@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jaroslav Kysela <perex@perex.cz>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linus Walleij <linusw@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, greybus-dev@lists.linaro.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-staging@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: (subset) [PATCH 00/13] PM: runtime: Convert pm_runtime_put_autosuspend() and friends to a void function
Date: Sat, 10 Oct 2026 10:42:36 +0200
Message-ID: <179162175231.5836.15015381844446264252.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hO96nrCSn40quqHyVqhWD6RWJR7XsqVI
X-Proofpoint-GUID: hO96nrCSn40quqHyVqhWD6RWJR7XsqVI
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6ac9fa8c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=3oaWUOhNWTYPA9BJS75j6A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rmSHi3-zQwwJBmM97rsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAzNCBTYWx0ZWRfX0XH0fd5aWGaG
 9v5lP8VGqMZvAKpUKks7ROpNSot2QMrin7SCMBf3QeXf0LygZV/ny87Irn+mbh+Sv7X+wNERQ8t
 lXjjUAGauB8pOyb3z9lDQPnGL8mIO+UP14teFtSGV7/VYboo7I+azbyZ+9Fxm9cKyfajzolo2wy
 XVxT7fOmrNmtInlvLYx6jor2021RcT27hijdkctnpKLkVj88QRrMLLUHRGilli0y/8D+umVoe3O
 VbOjfUcWrPC1Fc9YHbEdEgq7yxM/V8KzY6p9pQY8tk+KuGOyTEJv8xJr16PN7vTf5L5J/E8OKZC
 AU4lOvVk9lLSBQnb6b/pRG8ccR/4j44LtZv+uqEtt53c/XlxsJjUPVrJz2NOus3o3JwSEtwwrf1
 J0jkmcXp1JUllkBSm6KPXl+dWFPeNKtPagifF8CUuwTKZtTsOT8Q6LOQLKFrbuE6stmWc/5HgVL
 FtrcahMbOcmPkMemFEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAzNCBTYWx0ZWRfX//71M9lJs+0M
 a/tuoOexZZE97DLwjPwy/k1T66MmIkzN5uM22nR6wILoZzn6YlwoGvgCFKoOH9ZkV5s9RkHMCl0
 YAJoQiPedsk/80DrCwUGuivIaXf5eU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100034


On Tue, 06 Oct 2026 16:13:28 -0700, Brian Norris wrote:
> Similar to this effort:
> 
>   Subject: [PATCH v1 00/23] PM: runtime: Convert pm_runtime_put() to a void function
>   https://lore.kernel.org/all/6245770.lOV4Wx5bFT@rafael.j.wysocki/
> 
> i.e., commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void") and friends.
> 
> [...]

Applied, thanks!

[05/13] pinctrl: qcom: lpass-lpi: Discard pm_runtime_put_autosuspend() return values
        https://git.kernel.org/brgl/c/9bcd1725b0cc7954525e3d0d02fecaec7c7aab33

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
