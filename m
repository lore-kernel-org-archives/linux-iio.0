Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361761;
	b=4gCgkhuuCbxe/Fj1p0U9xSbAIorZU37AeWHEMn+IeH24q85HXrEaRE0NHUIQjUSfZymZ
	 fFl8AdCUfBVJb4Z6Tq86ZvYZhVoG1fpoX/Miad13vWdEEVGDjpOLx37uBvJddqobOCKn0
	 uVNR3SFsYQw5CfXxRZwcKQkIyJLjqLscOTMm/kAtKgkrhVsL6lGoR57jcLxdjPdcFLIkQ
	 a2PYNToqbGt9YtFf1YawHd5FBBvPsctIGVxDa2VAoiXwCU1M6TIZatGAIQALtvFMUKDVZ
	 M0I8GZfo7K4G7zLWy9drzaGftB6+xUE8KntD328fOz7s3LBO13qpZrL9uU7ynTCwCKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361761;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=96henQvE1+HZt5fuH+l96+xF8dG/k3UTEeRUD9yo+us=;
	b=Huser0XGE+zRrbnrvwiPmGLPouATVmRNnpAhVzgfywr7Eir7IJNTtxBcsRitBVg+zvCl
	 pz2D0ZxIWTNym0j8lfKjZh9XpRt4BriKDlIFyKm9h7lKdszdCsQGfJCNeGH0NwvOHGZPN
	 wCxdWSQWR6PCR4R9ttHX5Bq3zpaEkD/jdAitw41OrQ5826e3+7PTQYz8gWVUTm+Uia59z
	 HBCJ1G28KDUKeTRzscA9Y64ul2OfRojXhVINpn2YRjkxGKoVSBXd+/doQcI7WZdzL0J8/
	 p9dReh/CVQx4uos7N/Q4zqMfI+GCYJh0/B+wTFSDX6FWPt99m+ol2ZzPo8Ehv9xYGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OtXHbjqg;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=q9Ema3xF;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A3606A321;
	Fri, 30 Oct 2026 12:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 547A3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OtXHbjqg;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=q9Ema3xF
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBHggn3601511;
	Fri, 30 Oct 2026 08:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=96henQvE1+HZt5fuH+l96+xF8dG/k3UTEeRUD9yo+us=; b=OtXHbjq
	gefEo71u6sC4OqWNFsGJTPcb89MEX3oRyr8VFDBl+vyMDzyIOYQBXQI69WOjdTyW
	Lu2JtEUVO7l4cScIS2pnzzCnmQ49nnX08sEiCEbmL+h5+A+jUbebBCVHl79iaDtu
	zVtf2BaZr2biNr5OHKCsRqvUf4je7zunOU+541ZO47lkm5yT2YLAy/T2jTYmFQLU
	XK1MHPO4NiVDZImG2cHCycSfMbT/UqzbGMxRrS68J2LRTNbIzzwJAcN4SbVjmbcK
	bRFcgxfen6R5WoO89kMFitwKYkEYvcKSa3d1ML2wRiAhVDpGt7xDZFoRhJgKFJDt
	zBqVEb03HLdCwHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=96hen
	QvE1+HZt5fuH+l96+xF8dG/k3UTEeRUD9yo+us=; b=q9Ema3xFe+dn5c96fSyfY
	i4gxdY/HjdpLodUccC77itXTznMqpski+ev3BXDNDoWERpjjVGHlJGTCZ3MiraHg
	6nvxLLmt+EJNz+iPWT9FOeTh1fkunyCANr8XAfCAPFYbQul4qE3vY0kG41qxO+Vg
	pkxXyq+5DJt8hH7oI+BbsFjao3TUlisgYv6bokRB1mm2NAoZGKY7Nnz2bIigOrM8
	ZZRcojyEMOUnlyq+JJ1aUi+tNZnf54+nS4WQjumnxJ8Y3F4MNEl7nBCrgX/PODdp
	rekB+5DmUzxTiIq6qN8gZ+IpJzh78a6yYt6h3vIyeW2eiXGyMJcnzErghAvomgcr
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bkw6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 08:02:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69UC2b3W026750
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 08:02:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Oct
 2026 08:02:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 08:02:37 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UC2Pw1022899;
	Fri, 30 Oct 2026 08:02:27 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <jic23@kernel.org>
CC: <sergiu.cuciurean@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: add ltc2387 driver
Date: Fri, 30 Oct 2026 14:02:19 +0200
Message-ID: <20261030120219.269274-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028023919.21834986@jic23-hlaptop>
References: <20261028023919.21834986@jic23-hlaptop>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX4N44qNmROW9t
 +NFfxgK23gCDbAPky47Vqo9045BLj0e+OnbC0lyiQ1UCNcmoHozi2PqohPnnjxjqQJ/4j61/Lnf
 T0/RpN3h81i3nbWoO04JuejDLmkXs4K3xgcKffrtM1JrXCIgF65RbXElABr2uKW1CyepCLDWfCj
 9Yq0LugbJVtr5RDPg5GwTu4WTy0YsDbIt2W1JGefbKmUxhGRarVmG0BZd1JyZyCQeRiLdIwkVas
 jqk+kIx5s05MtbqEytFFaim3ktJVqIH9j1DxmpLOOT5Y6Q710UP8xNsAFYZhXcLOhFqDvwRiQnI
 Zmq7Y/7ITZu3o879BSGTJL+SiaANIW1/NQ9ujLA9A8OqI3jr2CYUV0aAzA2678MuviQwOqe4oIT
 fJpiqnPHJnZP8Brg/8vA1kZ2L4lbunhwiB2NOjCxr3dFAb7G/GsmDJnMpYgmTJVBCCt/aSBC8gx
 CrmdW9GM/8EwnN/8UwA==
X-Proofpoint-GUID: gC7-XLwLluY4oXYDrKyp3yH5Mimtlj1Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX6fV8WNhg0C8K
 dLqN8l0qLKl3c5FGxnIMaZwclV9hDyV7lSKu+74kFCMM2iBj7U6pEF6QbpmIdG5NObqtmnDmMGM
 Nusgtk14W8Wr6d25J2tqwyBGE6+3kGRN4+2WLo0o9kmU4nu3dtpQ
X-Authority-Analysis: v=2.4 cv=XfMcX455 c=1 sm=1 tr=0 ts=6ae4875e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=uE9H6wZvhtsX-QESqpUA:9
X-Proofpoint-ORIG-GUID: gC7-XLwLluY4oXYDrKyp3yH5Mimtlj1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300047

On Wed, 28 Oct 2026 02:39:19 +0000, Jonathan Cameron wrote:
> Check the docs on this.

I'll drop Assisted-by from the commits in v2, and describe the AI use in
the cover letter.

v2 will also cover the points on named chip-info structures, devm clock
and PWM handling, probe order and the gain property.

Thanks,
Daniel
