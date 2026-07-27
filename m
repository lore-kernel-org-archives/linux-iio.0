Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F9377AAE
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162373; cv=none; b=EOoCb2jqRGFszBI7KSjrlUa/Z+rrAcs/sPTGnaOb/Vkl0IxdoryjvJwLYT4Y/8MzNPOuL9SHJfHQHvjXKlHy5CS3mLSuAxJEFsNTu+O3ZV5QXCkbU+ZMVZebifG8mNWKWnH8DayfUtpGt/s9s1hR0G3FUy8wo+HnRGLJPAAODC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162373; c=relaxed/simple;
	bh=xBrj8om7cZyJutOzs5H4xLwjicqpb4hECpicCs4d5Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9EkCLqHo3Dlr50JrM8TAsFZ0TxbnO1Dnx5lGH4CqfDtC3UnOX/r+8Gt3hXLUf83+Ew16jJ65h/rFsZ1l4J+cQKKQeuKbe1Toq8Brru+rJKCuFqeXq/hrVeLESSDyRKlBHSseqv5U6Dw/ZUtXSxucVN4vh3uKaEDME/rw7sUqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fw39adlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmZ3S4mR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fw39adlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmZ3S4mR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlqtk3787376
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oy0mH4sOH578efJ6Gq+6ZULd
	BJ7VNf5OuMq0T7ZLoOs=; b=Fw39adlV1Dw8yAT9DITYXrSv26tgBA3e66fmtToj
	mEVio62D5SLx4V4uI6n93+d1Xj+TGTvIRCZcvBCPWqBTFzLGBv/RiMrHv44f/zv+
	QQ8qAIVgJYIeWVj0EvXWyJFYhXyacy0MUJrDYvQ3D2qREgMg3hoWvu5BzlZbF47j
	NvZGAzb1mfNwCpP55/rKGOzS05XRUFsgIiRdTRE//Rekd6dL7lpZdjAKEbIg34Yd
	lDlGv+aAHtDdho7apKCxjgcKbljJ0WS3MK2LUgiKfOHbcEoLqqxnhvrQNzYJXDCy
	yfWGp5Pno/s2bqeEidhQdCjqNE+wndeiX0PMW/q/pQn8QA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2hc1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:26:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52769fc3f2eso34046621cf.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162370; x=1785767170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oy0mH4sOH578efJ6Gq+6ZULdBJ7VNf5OuMq0T7ZLoOs=;
        b=hmZ3S4mRIG7RedK8Sjza+l8w+50hMFUF9yWQLS/FaiGBza+BMeJsHhpJMrvJxIAtGg
         rXvGFCvMdK3aHeaPx4rUc1hdNEWmR/qvKt4hp1FPzVvXk0JWg8pf7p8iXFKOYCIyM+vk
         EnZ5+FIgWzyO/ZjQeGnYusz77SkDaby5jNHuE+zKxqN2g2JfxuJRw/TiwcYh7pRVweun
         G4t7XVekzuV6BbZKg1DhukyZd8ITGl2kPCmSEz/31qtRkpzgK5NWlSXkvNtzT37z9rd6
         3Bdo1PqR5IjxocRzkqNxwm1/01j9pwSXrVeuIIcYeuWGJGv7CYFrvpz0mmwm7tvBGwXD
         I7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162370; x=1785767170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oy0mH4sOH578efJ6Gq+6ZULdBJ7VNf5OuMq0T7ZLoOs=;
        b=dG7j9awM5zB1+Cx98K0BCeABxW+QGVkyaq2F3TUONPdPdsaMFOqnD9YpcmemVrhlHa
         3ja574phPJsZPUVGylzrUA/ODtbz+SEfcBxeiN0EzLzTGybA/L5wvjggoJGMYhIhWmAF
         hbcB25Wy6aluhCDEcIRs/50l+zR3//UdLL+FP67CypgyfXhMI1bEw4LfPuc/eje/bqXa
         HVXqnY8ioWJeG9E44QRpGOICHHyoB+6I/9SIdl/kB7heqG/xh51eJAtM/SM8Am5eddAf
         1AnuOCIVsQmXGBxS77LAvN7FA7/alQfobiZNNXFlI3P04XbEzd6rhB3SXYt0jCButgdk
         EPsw==
X-Forwarded-Encrypted: i=1; AHgh+RoRNtg5HQCzLNWS+MiGqi8khbSULp0C0faALYwRJWKmDD9fnypF3/Z7PwOXyq+9gYY9lkLv1Ub1Xi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfsin/bSwFTp0CDhHsUSaoDqSehIb4EHaxSJsVRLLv32DefStg
	mkWC6lXy6vaFA8Y27QT0RPybEgGcbVjix6TQIPM5J0SaT/loeD26iKFfxTk6DnPD/Jwe56NvbOs
	Np41ybMgHA7hdUk11NwbzhFQNeLXjzhA1N/LTF/gC6kCEwSwFenn1/Ug0stMvRjM=
X-Gm-Gg: AR+sD11dRWG+125S6BsyvxmeIZ3MxzZT32iSxCHiU4rGWdeRzFTThsaD49vFt0Hy0nw
	sE0gYPRhY07si6pYhzFey8fLGu0sS2vR10GTQH6bj6MxRJKDpHPI1Fo9zAQsGqiAqVDOB+zYWXW
	GWnSpFIgr32iIO5uC/ljE8XEVvM9L2rC3+RnYKdUo+tjL5xFu07S0H1bzP2GzAQwi5B1rK3/c1z
	IOXqOgo4qF6V1JxN/g173wYSqoM5Fve3CB87WNsm/Qp2aEwoUT9RWE90R8HTl1T8p/DIfY17Una
	2LS2wHl1DTJVKmhZAQw4aq8LUkaveNjhmqPvdixYjcoT3Ew9yEew24/mZM83vj1q1JmbdGwRGED
	A6MDUZbrdsw6bE+o=
X-Received: by 2002:ac8:5714:0:b0:517:87bc:9b47 with SMTP id d75a77b69052e-529a85ed059mr87169431cf.39.1785162370017;
        Mon, 27 Jul 2026 07:26:10 -0700 (PDT)
X-Received: by 2002:ac8:5714:0:b0:517:87bc:9b47 with SMTP id d75a77b69052e-529a85ed059mr87168661cf.39.1785162369415;
        Mon, 27 Jul 2026 07:26:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm48323508f8f.17.2026.07.27.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:26:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:26:05 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, sboyd@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
        neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
        melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
        ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
        luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
        mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v13 06/12] spmi: Add helper to get a parent SPMI device
Message-ID: <tdx7aygeu3li6gjmzsxntg24mgcg5fkiz7c6oibuhucedupwjo@iqpnvtiohstz>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
 <20260721093626.96264-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721093626.96264-7-angelogioacchino.delregno@collabora.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX1eaHUP1HA/c+
 X6glDhFcDRs5Uy7mVpBclrV1FwCK/6VxFTwPp8peAlGST+MDE2toDaOawGCF6TweNk8oHIyDHPv
 mmHNfufodehTrSnKPiQzRZFvvLoRDF0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX2OsfxqEisAos
 HPa8Zzs/GBK0MJi4owYq6p91aFfZlEArmKatjP79Pu0iTMRervFQeeDtGyjVumVfEzbrKE9tTC1
 lpVDMStnDwMGXNsklra7rz9swy0OdmJeq3N1+XrVSfHrLoDdUDh7ljF4qtuXdK5NF5PHTtGlHED
 yeoXxomkokCfC4yo3A3jL1lAtAKpHQbsvw4zQg3dMj2zE6fGc+CFBfU6Bcnr7PwrEwBjVLVa336
 XuCv01DOmnP+X73o047VGDogpZHZfNHJxRX3IuCsdmlahHki44jiF5BCEezzjxVSqsJG6Gw61EY
 jPiGpwIbvG2Z4f3SEjMW7DGCA/+wpVX3yJa/3mqj3yZT0N9FzC2+BEGrOR13b831XMzSLaNYhfm
 S+dVG3DJFh9sZJq4CG0uk9sPPB+3g0o6O42BcR3O7hCUl+yzxYI8A1JUuRA3mJH9sz0DEFfNzA1
 KKsf1YHTmF7pm6rDYxw==
X-Proofpoint-GUID: hJokBmoj_L8WkCeDiPDzcu2p3H8ro-xX
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a676a82 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=vXzjEk_Rc76YdSX0aKIA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=kacYvNCVWA4VmyqE58fU:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: hJokBmoj_L8WkCeDiPDzcu2p3H8ro-xX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

On 26-07-21 11:36:20, AngeloGioacchino Del Regno wrote:
> Drivers that register a SPMI sub-device as a platform_driver are
> not guaranteed to have a SPMI device as their parent: add a new
> helper `spmi_get_parent_spmi_device()` that takes a struct device
> and checks if there's a parent, and if that parent is actually a
> SPMI device by checking if its device type matches with SPMI: if
> so, returns a pointer to the relative struct spmi_device without
> incrementing any refcount.
> 
> As a note, in the specific case of using this helper to retrieve
> a SPMI subdevice's parent, the spmi_subdevice_alloc_and_add()
> function does actually call device_add(), which will already take
> care of raising the refcount of the associated parent device.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Looks good to me:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
