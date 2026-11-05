Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859216;
	b=GliASOAMAoC7WbsZ3IzOVcO8smeSBxuNgIGeW1U/CcpznfX7eu4v0o916sinnV0ePGRf
	 HjbMJfFY5ArPy+5gteVXOQaotzDLZVxaOBdQEx5MIsLOlPUDfZ/Kh5+I9rkqvHVjsYpri
	 XzmGZ6OyCkg0mXqk/7t8tyP1wiZuLbbMYqUOXII5TfTrcn+ve5M7RVSGmz6lBzCw1xTUQ
	 N66BNFo9eRx36TKKxFAsSIFzS41dZAXWzVADBMRv5SL7wvSzpEC+8q3oB9QD0/eqzDf0p
	 hClMWB+Yha51bdqh1LXvBSCFszeayDSC/1AVvJe2mNbC1ZV271Eiy6PdIxjpy2xdbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859216;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IsVYhkYmat1UQepem2v+UOttRyhojY3oE8jtpbiYWrU=;
	b=HqHAo+/26216UulaFMx6cxX/11DnIRT+hkPA8hmee+/MHZnyEBziy7u83pGDXzKCC+TI
	 HR8ouXP1g3saXTeJZhNeLjQFNjBb3BN/Bxg913vXLk9yxfFi3JcqXgUei7iT4tUm4A3+n
	 oZZ+G7Yeas93W4JXsgXTAg69JwFbHvvTsgbstd//gfp4Q5H7BzsR064KYtFSH7x+9KGE5
	 JKPyF/mHbQqkxWkq5SxBSsMDBach3fTRGMjCAZw4O57jTrl33YXksM4e/zz+WzkAHrkla
	 FryhmNbn5cgYfttgu8u/5uAK+IdTqyUmnhH9wwiSe/CdXcTCTZLD4Gvz/afmQLWGrNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bK0phown;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dKXH7slU;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD92606A31B;
	Thu,  5 Nov 2026 06:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BD92606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bK0phown;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dKXH7slU
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A53olOr306154;
	Thu, 5 Nov 2026 01:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=IsVYhkYmat1UQepem2v+UOttRyhojY3oE8jtpbiYWrU=; b=bK0phow
	npGZ9ntvxxp56b74h1y9ziG1tnIfYj0f2cu8HTfrc5dFQ2qlKu1C0cNoUhWuOYrx
	w0zm2JY4M1cvBA0vIwt1uCZ3fnGLCDbgehhDUeYID9W2soov2JhXD8pDFGDXukO5
	0tMwWfEMfa+wZc4t5SSsy81vhVUpN5HxJS8MFtX3+c6BF0zlmYYnydAag6p9S3cC
	lxD+ae7z7UIKJnx1HUR6UVaQ0p9ysyEBH1Jg2rMEqb1Ij7Ayr7jDw5TyZiEbhbI6
	8mT7sgTrkWIx71B/M31UeL+vAZonWJmrlTTXRLlavsN7eDT1lz2Tz1skzS3Qf9+b
	rFuFr7tQCxNTmzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IsVYh
	kYmat1UQepem2v+UOttRyhojY3oE8jtpbiYWrU=; b=dKXH7slU+YXgSla+u/saV
	yKvttlpS23YoriboFOJpAP+GHmvOdxlblIiVzLhOdFGymBDDKZiVpBFgEO9JxxTy
	Wq2ybHUhpGdwMsUvRcBWXnNjKlBe89ERkpzrKi+sFH2TZTOEZc3p2z1Cfp+3nSv1
	SnDtqezfUiCu3D/CvOD6TrXKZgSx7TTqQq2wkV7iK+isVc/VA4Ju8q2ietE6/Y63
	LeIzKXwT1sSRDS7GfQohvvtaAjLK36mLkZt9jJIZUoCWsJaQjZVYGqNfTGaL94Sj
	BVtG+6PEQhDO/sLKntYrpytRLz+AZ1JW6TTLvyQxVhNX2h76+5U1qOY/ggk9+/8h
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hre3mj4g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 01:13:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A56DIMb018455
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 01:13:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Nov
 2026 01:13:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Nov 2026 01:13:18 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A56Cw0s008937;
	Thu, 5 Nov 2026 01:13:01 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add support for Analog Devices MAX30210
Date: Thu, 5 Nov 2026 14:12:49 +0800
Message-ID: <20261105061250.1691-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <dd1f8bf4-0dc7-4d89-9eee-8a08e2d5832e@roeck-us.net>
References: <dd1f8bf4-0dc7-4d89-9eee-8a08e2d5832e@roeck-us.net>
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
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyNCBTYWx0ZWRfX14pQHbk8Gb6U
 gCPA0erUVz5VSg2KTTfRcv5zUWqAOt1F88AZHlbRWDqc3wvtvI5HUESyvNfFNCrbNQ39FJu0hPq
 WCYyVI36BpduwqOQMfvsCXkdgxgL2fGmZkLRM03DPkFc9cTFNBwgCpX7Q2xDs8nQIw8cSq+6w4x
 N7UbXKx43Agtc19akMU/sv2jzhrnZreMEO8uzCtS7wzOom21vYMbp3pbtrs0XuH/aT6827Gfdqc
 Tpp0gK3z281p7/CwlXQSademl5oAzrYZWTvnCNsZvK/Yrhi30jcHEcDjoUjB96AbG65vQYW20GC
 JRckZSapvCCz9TbdC87i23JZ39qQ1bSkDZW7oMp9VTYkNvz9DXuxoDZt+Q4gJriN7Xb/C0PvlrY
 G31i5P2z6DrZ3nsSQVhMqd9ArHpsQVQ3GDzvkwOoXlXm4m1cMDngToF7SdaoYO5y9GAaoyQMS94
 ToU22wLcicrMXZp1jJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyNCBTYWx0ZWRfX7pLkqvaJ1wQt
 9JLFhWeVZqKFWi0XJMck0siDOQCF98Eo7NQ0Xi/1l+r82BJ4o/ZBYY5m0/jOc/dKnkmgV2AIffV
 2eoyjJKUhpCV6J5ThShtJ+ANYTsthlMk/bVYrTayOn/NzKUYkDMR
X-Proofpoint-ORIG-GUID: uonwnaqbgPoWe9t-lnyytBWp9ATJOwfV
X-Authority-Analysis: v=2.4 cv=BvgIUoX5 c=1 sm=1 tr=0 ts=6aec1e7f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=eqFOLOu6k0bbPPXzj5QA:9
X-Proofpoint-GUID: uonwnaqbgPoWe9t-lnyytBWp9ATJOwfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050024

On Sun, Oct 25, 2026 at 05:10:05PM -0700, Guenter Roeck wrote:
> On 10/23/26 01:06, John Erasmus Mari Geronimo wrote:
> > The device provides a 16-bit temperature output and includes
> > features such as a hardware FIFO, programmable sampling rate,
> > threshold alarms, and interrupt support. These capabilities map
> > naturally to the IIO subsystem, particularly the buffered interface
> > and event framework -- hwmon has no equivalent buffered-capture
> > framework, and its alarm attributes are polled rather than
> > interrupt-driven, so there is no path to supporting the FIFO or the
> > autonomous threshold comparators there.
>
> Oh, please, do not make up stuff. The hardware monitoring subsystem
> does support interrupts, but it is not mandatory. Sure, most drivers
> don't implement it, but that does not mean it is not supported.

You are right, sorry about that. hwmon does support alarm interrupts
(for example via hwmon_notify_event()); they are just optional. My
claim that alarms are polled only, and that there is no path for the
threshold comparators in hwmon, was wrong. I will remove it from the
cover letter.

The reason I went with IIO is narrower than what I wrote: the MAX30210
has a 64-sample hardware FIFO with a watermark interrupt, and I want to
expose it as buffered capture (IIO kfifo buffer). As far as I can see
hwmon has no equivalent for streaming samples out of a hardware FIFO.
The related MAX30208 is an IIO driver as well.

Thanks,
John Erasmus
