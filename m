Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757346A602;
	Fri, 16 Oct 2026 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142520; cv=fail; b=BIWmoPHm+asB+rJEnPdnRqXl4Hoffp6FRr9ftV0NVrkeMrGMeaB/Be0MemBKMYaKPdDdWKHTYGahFi+Ds7ixcwThjwvc74lfO9wpfBx9lIV8Da6/rRveQSVsswNBcrcnUvWJObsKQxK0FWkcx2/FrwOh6rvbK3MDw9Q7qK/uHgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142520; c=relaxed/simple;
	bh=1F7Oou3+1DJGW6oLDKcgvqHu4RttJLJ9G6NXHA/9Cw8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=diV4F70Cv/9hTaurRTo4Mmr80kqOCf3/gfhtWWc/+X55Qx/HPjHFu7DeX7r9dMf2tXuU6Mj9F5mrHu1tanbVXt8ahDNL202fHDYVhSw0aPiI2WLhIAEwav10/ARKMW310qnk0+uWa1f8U5JD6PNe/azOya5ikj9HtlouAKcAFAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=HRyaZ/HM; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xcxHUkxl; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="HRyaZ/HM";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xcxHUkxl"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8onwS3231880;
	Fri, 16 Oct 2026 05:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=xlfJb20VoQ9Sg75qoTl22aI6d2ayVEAQ1Vmv/rke+yc=; b=HRyaZ/H
	MSqPa8oJg6gXrKA1jE2PqsYDgmrKmAQE+n+CUSWr4FnrlAe+cKlUoDOUnVaT/ED9
	vHlNUrz1Nx+vvY29LGYRuWgFSUyuXwJrUeWPHgg85L5umhhkQwsPInF+r/WFH82O
	NsnwIZVg+1jvkul3wi5QmEpDKo1qqhRXAfcw2K75SpfhEkz41aWrDcWxlcBwGbAI
	koiRGp/rq0RET+zVaE5nQTiHvsJyCNAxslTEnnopFHNcN+wVX7ILpgIXNh4CvxlQ
	6j6eyX5Q7WjBzokpuoWW48yqNrYirqrU/jqihV6H9dUupWFh2uv3TEpdE/J+VqQ5
	yh3tyoMNY5+qSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xlfJb
	20VoQ9Sg75qoTl22aI6d2ayVEAQ1Vmv/rke+yc=; b=xcxHUkxlRsIwbB3By/IZg
	8T88qoLvSzpkRvU2vr72FDD2L3iomDELAXRNDI6R1tPJAZZ8scwIMXsfHbhhB1dg
	t9HVY2vKmlPtqiI+sl4wrkik1173mqSIFAZN1hJzTZC4PJwoeb6jPPBoFCr+xsGT
	cydyy9ORs84gM1Dmu/H00j0ZjIYo4Rn/cpiLwFVSg35AhbiirMZty+f5tYpyPLs8
	9y757xTRWlY1iiFp7MEUurH0FgaZp2/cYy+JICuz6/jbw+nhNPmDiZPPcjeSGeza
	MbE4UbSSJMaSYZER8sja5otLXeLtAK7iiHhBZpvV1X0TiuD0r7Ud+En5nviwDN3h
	w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hb3xxksqu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:21:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogEQjf/0sRL+iWSp0fP5dhmPOrytadRl3zbv6rg6gVYdCUlPaIq8yzJf095lXLkkrxnbhUhG5sBqgC6ZBOA5AdLUk0bJdn2o2aj3xaHFIt3FNAwWc3sr0fzJPYCv1OPDwX7/UkiplhVkrvweasoNk21YNE6k4je+4RbtaE49FN4y2z/+XMmQYjV1PWnDg3K0qCiG2dnz0roNqKAiz2FJdjnqZb+ROKZl/mal3p+ZBFSJFtMrXU4sP3rABK++v88UyTG4MOcIsF+V2fpxTFOlOPEYXnFy3EasiR7rg0+G+hrmzTMXxOZq5BSn/YC7eYUloIYPmU53gy3pBtN6PdEViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlfJb20VoQ9Sg75qoTl22aI6d2ayVEAQ1Vmv/rke+yc=;
 b=ZzyseGcmzFUPfjuKyYcGTWA8u67pjC87ias6oIWP0dO1zPq1KrfhK9LQwdOHoGpbfMYnHc1NNwzJEVZfYkk/FHioweJgEvC5lhrBcYnU52+wEV8Gg1oTqZAA7YRFXaj5T+nNxc1wSpv0hxzw0rXOoArxz+B5Vfzk1kq5Gh6Yww65T6kVyQILymX0zlb6cpj+JwQMpSRzb2MU636uSOPEvhVBj2wykAlmA+pBe32nQqyblnk6fDfMaUvkSEE/KLZ1VU38P/aSS1TxlEVNMVEcfPmPGG+anfsIRMMb2m4b7Xtj9sY+W0evqyoG4CNQNz/InkakGAdKKaIe1VQR3BfvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:21:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:21:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 08/10] iio: frequency: ad9910: support iio backend
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261015-ad9910-backend-support-v1-8-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-8-3c21648c8e26@analog.com>
Date: Fri, 16 Oct 2026 10:22:35 +0100
Message-Id: <179214255503.3322.11520324960275490028.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142556; l=1784;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1F7Oou3+1DJGW6oLDKcgvqHu4RttJLJ9G6NXHA/9Cw8=;
 b=Byep9zTnzRkuwGo2y5+jaXVSyl3Z+4cerkSM/oLz8B9fg+Oyt3fqLRQDdVuVo1oFMXh77fNeA
 lvr6qkEHszFArxz7GzPpwrGg7grxB4NHmmjDpk6EcpG8RAgUA1Ygz6R
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: a728148f-3b56-4ac3-9bf3-08df2b66e21f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 QOB8OBWMr5LfrQ41k9dXBwmzUyHG34BhPEdrHv5B7pRuY9t5NWXo3TcENxQsvIHbPzUq7Z/jDA5mN9txX7zyHZBbeQvNAiAhvT6SbF9zhQbqf2iRCUAN2YAvQbRY01fKoDihyfme7NciGzi80vyuVlaDfM8HwF+qbVJ3P1HOConbwgU4yN6KXcxCzYtfhyGzhNa+MpwnCY71YDIvCvA3koHZ/Rl2IUVWRTzWyBQHHLg85nR8oKogGLRGWTsawA5B2kmuTY6fekMrQ2lMZVyUy4L5q7UPjzsqeLxCX5xJamEgWEb0RTcXiOkzJ7CaM6aQwomNefEorYtoHnZUgkhW+M35+3rRD22STHXRhnFqaqOIImmnTlm5bSbOSx1EoOVbn8YI3zyI6S87/3pwfuhVsl9i46NaC6bxuRjDSXH4KhPSKcThjM/JCh4FrZqmtJ+ONFaS8UbKd//ObEPTYPx71x7TIGDoUNUTS5gr6AwAbvjSuGuFD9QOsMqAnC4igrnqJjUZkmY6tyFOHxmCoIzTVnFN3349cpJ3b2lP1Tp+pmfnUQlM1umM10crp573jzH6VTjJ3WVPoP4LUk65rDzpQDkjSikd8QKHfYSwSo7b6lQDwOO3RFHlN9Q1rKAmyEvEy4lUhFSk+F8f/+X1Qh7VksFzwqiXyDVoha/mL5anzco=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SHVkZFdLNENWNTJkZnhxYW9hUUdLSXRKOTFjU2lFZXQvLzVwRmhQUS9oVWNL?=
 =?utf-8?B?N2ZnbnF3SHFiRHNKM2RnNDc0YXV0VXVHR2t2NXZyMStjS3E0S0djQ1BrMnZ6?=
 =?utf-8?B?eWo2SU4zbWd5RTJOQXBCQ2NqbHBuL2g2Zzk4YUwyS0xoOWRtNjFoN0t6OXhk?=
 =?utf-8?B?Z2lJZlpiUWhnUWw3VWxBZXhkWVpJVDBYRno3QjM0clFES0I0U3U3ZFkxSUgx?=
 =?utf-8?B?QWYxQmdGWnAvNEFrbWZ0U3c2YWJnWG9CSEZ3cjVYNnhNaUQ5U0RjZmJqNWJK?=
 =?utf-8?B?dDFBVTc4VEh1SU1qUkQ2V0lHaEIwMzFZWkMvY0RFM2dPNnVvWHQxT3pWWFdL?=
 =?utf-8?B?OUkrMjNtVDNKZmFtVmVCaEZHdW1DWWFZLzFVcDltUlAvdWZteUJBUGdkaE1Z?=
 =?utf-8?B?ZVNTVXl1eUZzTG5ZL0hYSUdmdlprQzNwMTd0ZE0vcWRxMm9ZZW9jS1VNYS9X?=
 =?utf-8?B?M0lWaEdBbW1WdzYwSDQ1L1B0eHp2eGl1eFFEZ3UyN0l2Q1JuTmNkR0NIb2FE?=
 =?utf-8?B?VUFlaFFMRnJNa2xaNFNqS21nWDVUS0N6Y3QzUnlxM0lVTDFPVWRIckRFVlRM?=
 =?utf-8?B?VThrU2JLT1hwb1FsdzZJODB6aGRGTkUyVFFwSjN1N1d5VXR1OFZCdzF2c0ZL?=
 =?utf-8?B?cm91RjhZNEpEVkx2d3kzNTByMUFzWEF2MFAyNytZK2NUZ3hEMUZPSWt6Mk9J?=
 =?utf-8?B?M1pzSVlDaVFucEpsUllPMlg1cGtoVVJlZ3RiazFsQmF4bS92ejQwVS9uck9N?=
 =?utf-8?B?alJEQkVwYnJ4eWNBV0NYb3ZVbnFGbUhNOTFqYU1iVGU1N01uSXhoQzFyVStK?=
 =?utf-8?B?WDdRV2VvNVpCWWZrS0xWZ1lhTURPcXpNM3E1dkE3bXNCYkxFcTRiUk5SaXZq?=
 =?utf-8?B?a0F1Z2ptNkk1ZGxtU2dQZkUxUThObmJvTTBzN3RIKzdibFp0K1NiV1h2T0hP?=
 =?utf-8?B?R2s4R3hkbGN2dkRBMk1HUURkQTNQVHZJajZZSkZta1pCWU1wakRieEhLVlZn?=
 =?utf-8?B?aHpDZlVFWkpNTEg4cUpYclVaait1b21OKzBaVjc5YWw5K0NiRjd6TEhRdHVI?=
 =?utf-8?B?NGc0QjdnQkJEMi9TQVhVUDBtMmNOSExITGJ1b0FZZDZTZGpRT2hoc2lpbmhn?=
 =?utf-8?B?R0MxVnpDMmR5dFhSWU9FUzg3VDNIWUJUbnMrbUtzZWNYWThSa3prUXRpc3d0?=
 =?utf-8?B?Y3I1bGdvYzZwSnBtWndwSDhDUjRXN2VSTm9RVm52emcySWlSNUIvL0dRRjVP?=
 =?utf-8?B?RWlMZGVTcDdBRm54eXBNRTJhbnVVYTJ6ZnBmVUllMEtnNEF3eVpqRDVBdEtH?=
 =?utf-8?B?RWFUdndGUllodFBRdEkySmR3UFlYYnA3MTRKVFV5YzYvR1dWdklld0lNNTZ3?=
 =?utf-8?B?b1hsWkt4MzhOa1o4bEt2cEVVYlU4VzAyQklxT0tiMmJEUGphWEtGS3drcHI0?=
 =?utf-8?B?T00xRXZ5Q1NDN3hNblh6Smh4K1RBUXVxQ2FXalJnUjZSL2tnaXRERTE5cmRq?=
 =?utf-8?B?VWxWTzU0a0k2bkRUWVlJMDVBbDgzeHQ2bTRnQ1dsRXo1ZHJsU05DMWprcXlh?=
 =?utf-8?B?TW03L0I3cE9kTCtZbS9mS1dPVmFMRkp5MHJISWdXNCtUclFsTVdOMElud3Zx?=
 =?utf-8?B?STZ1MjR4RlFhaE91RmVQS0ZseGtSd2ZJc1ZzbTErb3dKbXRmME5vUmxldzY2?=
 =?utf-8?B?dTkzdUZLSFJtQ1pBQ2tsRDhSLyt4bTlWbGZGemdST25nUW1KVjBVQTdUTThM?=
 =?utf-8?B?OW1BYjdHM3Bub2RnVTRqdU5wdzc1bDJHamN0d0NQMm5HaDU3dVZQZEc2NUJm?=
 =?utf-8?B?NW9YWVlJSVpINWZMTXFDTUVPU2gvcTh1QWxubGE3T3FBZEgrbGhKNWlIbDhn?=
 =?utf-8?B?MGhLV2YwcWEydkQzYklodzNxLzVkWjZVdUxsd3hVNHN0UEdwNjRtMlM5Ull5?=
 =?utf-8?B?MVRXYlhpeVR5dFZ0Mjg1M3lHQjJNMnU3WTIzVi9BYktFM0VNOEtzdEdUUmVx?=
 =?utf-8?B?Rm00ckwwWm01OUgvNyttOWsyZDJiS1FVTEtRbXE2eEZiMjlzSEpFS1NhckRQ?=
 =?utf-8?B?aFhyeVRCOUt4UXlqRlFYZjJsc2dtanBJZmxHTXNZNTRKMytqVTV3eXRaeGNp?=
 =?utf-8?B?UWFiUVp6ZlNYVHV5a204b0g0WEdDSityL3M3U1Y2OTJtZUkrbTRKMmxzdnJB?=
 =?utf-8?B?MGJxaEJHRmVpUHhORzJCeGtJWThla2NNWVZrdWVoQTB4RmJlR0Y0L1NwTXJQ?=
 =?utf-8?B?VDFzUWY5NnF6U051b1BseDFtTlgxNjVrOWZlUnNOenhheEFrZTF3emJnM3Yv?=
 =?utf-8?B?SmRRT2I5MzRBZndEd2dHbGlZd2JUaFU1MFhTU0hZcm1nOGhTN1M4dz09?=
X-Exchange-RoutingPolicyChecked:
	zv8o/0TxHHaO3SbCx4L5Z86rwqVhf6CwPVfjtoEVpMaPuHPQTA1fPoaP5cYlkTxdYQ2mdPxJROH0hl05v9XiMkHWMOT1B+CYxJabz9ilCP3R+tqTXhIJHAlBBprPV2mbxoK7876aGGwTE9j3BbBegW2MVnwRnFSTBMmiTqYKgquwt97571AdsnH4Sm/bUr9W7mSUGh364KKuZMXJQTLJcif9tvDF77D2crnd0uIxfjGZ2FeaoP04QBATxh5fZxbbH/as5hN8u327B7D+XMMFv+m6CCAGAkcJC45AV4K9bCJtomrSiPKbNt9yEozMGxA5vr+V5URqBNlKAgq3bmpGzg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a728148f-3b56-4ac3-9bf3-08df2b66e21f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:21:39.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnDJZPhORBkkytgtRi7h+i14L8B9hl4zYiqNssQdA2J7fQ1aEp3NOGPoEZTu/y79N0pL8FLvjZHqoC0vdMKQlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Authority-Analysis: v=2.4 cv=ILKXmQvG c=1 sm=1 tr=0 ts=6ad1eca6 cx=c_pps
 a=IGlUesXJXvI2YQKUC5af4g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=KAEnLjAz2hW9CTxtWW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Xt5dWAoH16bgYgZJ4cn7-BuohxlI7llf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX4sIUVPI9qFqB
 bMM/LzkEitOfNwYyp8qT7k1EOrORVEFna/FUgviD5f2HOWxKGBxZc9OGzEBMBVGG5rwNQXmwDAK
 IkYAKg4eF2IW9Vl9dxue2jXHsmLDB7ikygIrB5zWmwI0aYUrrKUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX19cON8xah6Pn
 /yQ6dHi9s6lbTjaxqnkMf86TwojPI3wDzzsmNT4aiU+YdYdpZEf3r1ajCgVfeKocVVnpyD9ojaQ
 Y3CUIRueYD15mlH16dd5NqGYkqMHvGWariUylpLo6Rn30A2R+vU46FZDNUpr6niNMVfzNcZ2K6D
 MFVSKteiNgCw5QVw3sEUWkVKRZ2Qx+wRzCz66TtvbVFlCYFXwBntqcVZSZtdr3zPNi8e+5V2nHo
 NruZtagYUDWVRoHoVRxHv+eHpOYujb5WH9dRdFoPr++TIsBZbjpaoaORB4lMcTT+SrCZzDrm4TN
 FxIYUT7hT79r9g7WluvipoKoorJgtFqdabt+Qv0SD25FCZjoeoUGh7vsAgXhu1Z567JGF5YIGs4
 GB0lg6DVgQPWT8Oo8g4t4qzs8H1P54yH/KVLcLZd/Xw8L988QXdQOSmJiuKYZMg2l8XE1j34NJ+
 rD/6DYM/znoh56jsGKA==
X-Proofpoint-GUID: Xt5dWAoH16bgYgZJ4cn7-BuohxlI7llf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160037

On Thu, 15 Oct 2026 13:49:48 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index 3d517879dee3..39d65dafd5a1 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c
> @@ -568,6 +580,11 @@ static int ad9910_set_sysclk_freq(struct ad9910_state *st, u32 freq_hz,
>  
>  	st->data.sysclk_freq_hz = sysclk_freq_hz;
>  
> +	if (st->back)
> +		return iio_backend_set_sampling_freq(st->back,
> +						     AD9910_CHAN_IDX_PHY,
> +						     sysclk_freq_hz);

Here sashiko is right.

> @@ -2278,6 +2400,72 @@ static inline void ad9910_debugfs_init(struct ad9910_state *st,
> [ ... skip 31 lines ... ]
> +
> +	return ad9910_reg32_update(st, AD9910_REG_CFR2,
> +				   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +				   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +				   true);
> +}

This one make sense but we tend to not care much in other devices.
Might make more sense to accept the out of sync for more complicated
things where having to take care all teardown state makes it hard to
deak with. Given this is a simple case, I would disable the channel on
error.

> +
> +static int ad9910_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->scan_mask = 0;
> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
> +				  AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +				  0, true);
> +	if (ret)
> +		return ret;

In the same spirit, we could ignore the error in here (with some warnign
message perhaps?) and still try to disable the channel on the backend?

No strong feelings though!

-- 
Nuno Sá <nuno.sa@analog.com>
