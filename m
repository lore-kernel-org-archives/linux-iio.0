Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FF2F87B
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783817162; cv=none; b=IONzb/SV4RuffJAZvZpuEs6cZ3RSFNKeZK1RsntK/cCCvbEwAtZEsZaArbQ4jFRZAr4RgiH/fGJETEFtVJd79G5WM9KPjDZtBbYRcFrzXUPHbeMKcbhQfmtFMTnz0fElM3NdF0pnfQh+xRevmIc647g6ofGpTvs7315veXMddVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783817162; c=relaxed/simple;
	bh=exKrWSzeT1zMMDmBW1lsCVuCxYzfXeBz+wkkJ6+4Yu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fx6Q/WXblHUYeNSGh3/M14dyNm6Ay3IhhmRej4F6Qim2XB0qdT6OTr/tBqdyLaOZmhZGr6Dtj+GO5RR3UV6XX/22rjOdGP7ROs+h7CjqoFfJDc0xuAtnD3leVBgkUN9InKOEWcDP/j3XJHm9bazpw+OTJDsCmZQoti05KDLIvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSGCjccE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dw9UejNL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSGCjccE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dw9UejNL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66C0Xv0N1103810
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 00:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7gHjJ+2EaBeAOmvl0GqD5pQer6kwe0Xbvrh4dq2IQao=; b=VSGCjccEVbj3T4eJ
	+evFqZxaqyow154y/NfprEXiEr+O9rpH58vf++RFDafoeyXyPjyyj9Ag4i3SocXv
	AfrFZIZwOOSnkarYjj4/sEWylp32XfF1WHQMo5on/Ga/7TAeBQP8AMTHZzTu8MYK
	rObZsOmF7x9KzRoVucG4U45Sb63AAXt64QqRcCOoTOlZJaRBvhVRnK1ve9wn1mc/
	691OsU5fSQFszxi+OfFytCIzYcqlO7JG6WMe6t66Z3YzmgOLa+qqRP7ni/u9RVXI
	4zAK2VlXBzt+/1PVlzGxVRTYCz2l3oKEegbnhExsgi5D6m3SkuQfd+SdZLbt2v5l
	xPNMzg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamsx1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 00:46:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so352485ad.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783817159; x=1784421959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7gHjJ+2EaBeAOmvl0GqD5pQer6kwe0Xbvrh4dq2IQao=;
        b=dw9UejNLMjwfknAx5ZoAyKTtUS1V9ZplY2H/Kw86HwKcRMJaL0EkPe0v+mM1O52Ovm
         6HPvBtYPM2WHLS1EHYK05nCZ8vpH1jIkZJZq4nBcmK0U6hVNU9hU+jnzHlZ6yl6CQXhK
         wW/60YkPvRq+zmYAgTVgHEkMu3WRh4nouj1VGn5nWG3hNWORaHNSsjFapJ1QM8fyelFt
         Xv8c3xbg2yLu3tQLvRtDk/bYcvqEHm2NSJrVY2faKdgB4pkho6LM+zif7hiEFFErBdDm
         mk1sI3eJcLZZ0yIRIrbvdScsuaJG7hYvwhAmF71wQPFGeX3y2ztqGRWJFr39WMM12j18
         2yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783817159; x=1784421959;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gHjJ+2EaBeAOmvl0GqD5pQer6kwe0Xbvrh4dq2IQao=;
        b=dNhLO7mS3EErsIz6fhl3LihxYqDj/PUVgOXObOm5aZxLlaSB8L6L/oS6BTznWg1kzd
         mBd9sgs5fjakwTdzXq9YRnWRPZC4/GM7K7COQQw6/11yLi0c3XBbtgDhaU+uASM+FaaH
         7c8UVUWvnyQxdB9juYoYOgD32uBGIyGYX8GvrPuwHZa1tXWrxC9g2t0LmLQFNyfnB4Pp
         t/br361LkU2JDUDpDPksRertUgyUBznmA56MZNs/dVlayiFTAEsDaAxLwWYtuWrqHEcG
         5rLCATwa7NKIJa5eaFPcbNaGnqYoKcrHNEdUgc5mobQ9biRxeHEajU0YR59RE7WHfOWl
         Fuqg==
X-Forwarded-Encrypted: i=1; AHgh+RrjM8yWbTQWLP0Pu5YmP+hhORaaIzamENBH2mP+bK+ZWjjOyefHkJJWoqXAfdZAHT4bVfK/AYVGfKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN80rWvpTGde6mmvrQxlorI00UJwTv6AS35KxovljmFED6dR9L
	a6hGlDhgMKuNBAywKAQQLoNpr8On82NTYocS60N/xe2Zk0VCUDGm+hkeqP0G4f/VViavX65LMEn
	oaKFbwynjOeLAtK/vtpEhZPgawlKp0ywJhxYTUccwBkW5STtj9T5sqjls9Rj3P9zGtu0CaHY=
X-Gm-Gg: AfdE7ck5JXG3U58zyMZY5ZUognGBPUr9SOtPLDJdnJABIPfx5JM4lMJs1jpIxFiqhcE
	R6U6IdAkaFPIoWW0lPU+biZdLR9Rz3CiTRbW3OqS439CdBrhFd38Efmjziu7u+0NyUaUeznVxc9
	xpiHS4xxtjqOSVZZox1/773jFaQnmqKKRmj4F587YIIj/MHNESsjD7Yrdz7ZkwRZYQ3WTeAr7WY
	nzXFu9cGbguZ5zXnj0Z9qRfbh2aFAPylRuTdbJKT5hRgbPra8EDpTnG3GZN0WACXqQzB2almz9n
	oz1mtjBD599bNHDT0qxw79cgbZQNuwv5pheBKg/BLtSGRu1oPqgW5SB9tE9ur/MCjaEG8zKnrzi
	F0ZaYfF+4ZwrIxPumGx+IaVtUNW4=
X-Received: by 2002:a17:902:d98b:b0:2ca:75b1:e1e5 with SMTP id d9443c01a7336-2ce9e79f444mr43780895ad.4.1783817159393;
        Sat, 11 Jul 2026 17:45:59 -0700 (PDT)
X-Received: by 2002:a17:902:d98b:b0:2ca:75b1:e1e5 with SMTP id d9443c01a7336-2ce9e79f444mr43780685ad.4.1783817158937;
        Sat, 11 Jul 2026 17:45:58 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ecfesm79279595ad.47.2026.07.11.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 17:45:58 -0700 (PDT)
Date: Sun, 12 Jul 2026 01:45:54 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ariana Lazar
 <ariana.lazar@microchip.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: add missing 'select REGMAP_I2C'
 to Kconfig
Message-ID: <20260712014554.0032a06c@jic23-huawei>
In-Reply-To: <20260708-add-missing-regmap-dac-v1-1-e5925fb1fe23@gmail.com>
References: <20260708-add-missing-regmap-dac-v1-1-e5925fb1fe23@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDAwNCBTYWx0ZWRfX5b0pX0AfUlDq
 DvKM/++FxgJVt8sc0TQEB8xJ3m9fFoOhnZn0Iti2TDNo/BN9l/ZzsNbzLu4HBHl1FYTB/6ikoE1
 hvH1tpeGJ4rMK0GI+B2wQUymLpoXYg8=
X-Proofpoint-GUID: Ifygi5nzuFy0L2O-KqkMmqwH2lxQXGx-
X-Proofpoint-ORIG-GUID: Ifygi5nzuFy0L2O-KqkMmqwH2lxQXGx-
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a52e3c8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=j3typ809paJY_mESA6MA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDAwNCBTYWx0ZWRfX/AaObgGgdul5
 8FchDBMwzMoH6VSYvQBap0Fe0W4GDPm0VS1GgXi0vSctfs2rZlYqSBsVke9nDSJTA5n5AjANJ1j
 MmaiSUzZI5Fxz8EmJU9kwkU11XExpbmHIyVYSKNttd4shtmrKqTpjTXZ6LeJgpnPaNgqPzWr5X/
 NpX2h9SPENnVEY6yOo4nohBOLndJYXYakhSwoqwl5Cp/MO2R5D58eQH+wUzs+IFSA/frneXL2+z
 5fnYcyqkbgUTP/v/NqhSe71XQWXQnjgwdabwV2JfiCf5Zrjwi4rsL3ZNtInf+n1IQs8uZjpc721
 Mdi13rvTqgyy+vPb7jA+wsAbTfbryORmHc4eoAryD0UNTM2++iWvGzGYh0qwN0Z8LMxwlj6qDZO
 PtADi5t6OIEj03TpWMmCTtzLntBhbY+IBC3p1T2IKlkJpce5L2UyQMYeMda9LMiAUcrA+nRIB5p
 QU5QkDzkNgmcxQLZemg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120004

On Wed, 08 Jul 2026 21:50:28 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The Kconfig entry for the MCP47FEB02 is missing a 'select REGMAP_I2C',
> causing build failures.
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
