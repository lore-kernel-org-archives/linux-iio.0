Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6F3BA25F
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330481; cv=none; b=mH+j8ekbpN6OoMywAidoYYx4D4bSitkmuWcF4It/5XlqKzL3Yk9uwdjQZTYmRSxoXRoMQ1mDXMoKKiFtDWmmRSaY/4uarBCxx9j3Ky+sEwe57/DHzYcESlnMoKfSa3Nl6TwjAa8HXvlH8xoSXyS/CZG1Es+0UzhUh7ZyySLQaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330481; c=relaxed/simple;
	bh=LM/R5GJ3W65RUxksBT5+1V2AWVwyuL4cZQjhUCUDF78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a53jUO/l0twTCU4smyTejsa+KmenrqI+S0Ljth/LwFzSura6ocBdrp9l7BelFIf89r81vyHWrLxAgpWF87ZaSRMwSN5BOT0IBVvMaLPBKR7GxzPp6PJn7HD4vRbqv8msBS2S33RMRHTSwBllwubB1N0xcUWwGaYOc/wWXIu4ypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHZ22vAG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=etR/0O8d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHZ22vAG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="etR/0O8d"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNETCQ3178968
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LM/R5GJ3W65RUxksBT5+1V2AWVwyuL4cZQjhUCUDF78=; b=nHZ22vAGAWtZwLdl
	9M6IdhESLwNjyhehkoNLXbgK+pJm6xzdxLwjLiCTs7AzILAnbiMCVuam4nH4jpps
	Fhd/5enxS6Plcb+mQlkFPikzpHB7BoagrQd2wBEdEkmTc59FaNFfW5hCPuTg+51u
	3OHua15eYPYgRqgYkNBjIp6TXed9EB0Pgyr6tbE/GQRs9ywr8AemxRWd4/iSTJ4F
	rIVz6K9QJt7klvOvqwAHfTy5tFnxuFipHxxelA7Q1cQVeC1CWBsTMKfDr8gQ3GwG
	gAc3PpId9L2GrBizc+h+TbA72d4xq8O4Xs2IIz8zMA+tbId8GH+1hQOxR1pUjwUT
	+DqBeg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug1qjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:21:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso10640959a91.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784330478; x=1784935278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LM/R5GJ3W65RUxksBT5+1V2AWVwyuL4cZQjhUCUDF78=;
        b=etR/0O8dAoejGeqTudTP+MTSueWaUUZ9T0SJhvRmona00/9PzCtP+wkY5YVlHPBoUn
         MM4YV8aRBDlR1MjGwcbK3Iqfhqwx+8NRFNPu8uw6fL7sApyzCb+8dO7G2kf+sIOEOapv
         d7VLBs2QF8/yGnB4uDZ+W5FFqcso904fMSnYzn1QZ8c/CGlVaFW3ia2a6KRnF6ZgH3nc
         5B+A4yfIpN2IDLTBY2qU9v+ULMfvfQzYOrkaFiJvXz/UxYKYx9geyzHGOg+Kz5qEGxOK
         Qyc8ZyHtuaLPWJex9aySKZMuFVey/DVbZBRprcIxn4C2RL+IRr3NQ5q9S922phlXDGyd
         +r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330478; x=1784935278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LM/R5GJ3W65RUxksBT5+1V2AWVwyuL4cZQjhUCUDF78=;
        b=pCgGAZA6ZOfR2aIefGWlSmhDLUE5LSlLzWmiT18tcitPpqnbfHfZrrBUEtJuYsngbG
         2JQmMDhSbsgGKUXkrIDiCyJ1x398AnB3NrT2TMTGveh0sKUJne8GFGaUcMlzKLWu0qek
         KaMJ8SvJvIFiE6gxkMtpXURzZnEIEcyBXPPT/xs7/qLMz95vTkPJaSrLB8wG92CF/4r5
         IPdVBg99ePoGIHcz9FqfK5ExlW4Mn99Q2ZspsK3V93tM6uL0UhbM5JxkNorFJCOPC3CG
         6TLnkyDg7sB90OLPkEL592G7BqnSQY5SNA2CRqCEvJrR6Wu5L4YT6tikN8TYgTiO1uVo
         Gvqw==
X-Forwarded-Encrypted: i=1; AHgh+RqYlpcCBD4Z3HV9UrwXMRqU9D/Ojg1CxdYUfTARquRHQbm4jZaFQDMbH+gBO3b8CCe4jqX1BuEpJK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOIwWfkPanxlOwdvPRZeW0LP0w7207pKB6K5qCdjsYh1pQBKE
	a7Ou7xMV6OyXuxnWfrKDSmITwVABt/QCLLaNpoG3HSJMQQlaFkQhDT5FY1asbes8fHV7vaBH5an
	nb0QYXxynPhMAXPbHXmWLD52XHlMDeVO3pdHoWbmZVywaEBh+5CubZNO9hzyup6Y=
X-Gm-Gg: AfdE7cn6q3rjlZF1R92tf60K1EV5JbDVt7bHZlH4Mt+s8D3spFK0WrBI3v7HKh8DwVX
	J5BGOqBPkUBNAlBqk46ZE7zRMfdDRU7dvyfezKiSf5mUC+NU/o3hCg56paS8haOwW2d4JDC70Xn
	q0HWx65SH6S4h1tuM7LbNcB/iMTsC/BKosDK3fvUrTJtaCp+uTC8ekx2bnvfuwSoFDSl90EhI6u
	/pVYMB1hAbe5oTG0cEQPZW365fLAWfI37+S/aapWElHfzRDngesSneQPnhIWGtnE08892UVO5Cv
	YQafXYXv5CApmlhrEvrOO3JQWa+GRNDcc3ezG7vRybq0lDY9vf2QtS922p96ybtS6vOQV3afsEw
	NsEaW3kEOuBRiS1ET
X-Received: by 2002:a17:90a:c885:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38e4b538938mr5095283a91.21.1784330477696;
        Fri, 17 Jul 2026 16:21:17 -0700 (PDT)
X-Received: by 2002:a17:90a:c885:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38e4b538938mr5095255a91.21.1784330477249;
        Fri, 17 Jul 2026 16:21:17 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39de7790sm3735993a91.3.2026.07.17.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:21:16 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:21:12 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Petre Rodan
 <petre.rodan@subdimension.ro>,
        Dan Robertson <dan@dlrobertson.com>,
        Matti
 Vaittinen <mazziesaccount@gmail.com>,
        "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>,
        Takashi Sakamoto
 <o-takashi@sakamocchi.jp>,
        Danilo Krummrich <dakr@kernel.org>,
        Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,
        Siratul Islam <email@sirat.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Xichao Zhao <zhao.xichao@vivo.com>,
        Waqar Hameed <waqar.hameed@axis.com>,
        Sakari Ailus
 <sakari.ailus@linux.intel.com>,
        Dixit Parmar <dixitparmar19@gmail.com>, Miao Li <limiao@kylinos.cn>,
        linux-iio@vger.kernel.org (open list:ADXL355
 THREE-AXIS DIGITAL ACCELEROMETER DRIVER),
        linux@analog.com (open
 list:ANALOG DEVICES INC IIO DRIVERS),
        linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH 01/13] iio: accel: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <20260718002039.45096da8@jic23-huawei>
In-Reply-To: <20260717094408.509583-2-panchuang@vivo.com>
References: <20260717094408.509583-1-panchuang@vivo.com>
	<20260717094408.509583-2-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIzOSBTYWx0ZWRfX4bpe1Eo7Tlrz
 Tml4EM3aSDQNNLXLSpQC4taXjwdD3SnRHHIrLZHvExbiirDS2d73yYmjCBVzKyyY6057vkt+PeO
 WOO6bNcQ2Z80gWd3DpY85qieOvT89jYuMYpiApD8DvvNnjSnPCqLYmPXBIZ6pitjBrWdGPbRHXz
 KbnPY3aLIF2WaR+d5rNJ8+xH35Jd/B6vXV4Q4blQU6rOdUNdhZhiwl8WQNpzv0qv+4OTL5eGlbk
 AZFE6yeD4+SYSdGYnUwCQXy+AcnTnj9vCyG6SDwIIkBf5AzeE3RTaSurQguk7oxqdIA23RjriqU
 egmKA6zZS9WV4s1YRVE53D6FDSkdZQ4Phq2CcqG3HRz/8xxHmU8RMd4E8u6KHyaG/47IKucWyu7
 5UP3Lc4mdrIiupioXj1TrH1E87ytebtCKEWs6ofr0PJUqgStbhy8SGqt4qNr6v2GVyos3ESm7zQ
 2OpGHFYfWvgRWJJfnLA==
X-Proofpoint-GUID: jij6QA7JzXtxVa1QvKHU73bfbbQgXS-E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIzOSBTYWx0ZWRfXyjHt7MQcuAnS
 8I5UsbpR3p/cB97e57FDYk/JAXA3OpEFfry8My2HfSpRwtJyfBDpwpSzV5tei4pHyjE+TwY8DUM
 0B3zNecy1FCQDTu7YegbVPqI6yigx5g=
X-Proofpoint-ORIG-GUID: jij6QA7JzXtxVa1QvKHU73bfbbQgXS-E
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5ab8ee cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1WtWmnkvAAAA:8 a=V7JvBXLol3YtFwDLrfwA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170239

On Fri, 17 Jul 2026 17:42:24 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"),

Please rewrap in a fashion that keeps the commit description on one line.
One option would be:

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),

Idea being to make it easy to grep for.

Thanks,

Jonathan
