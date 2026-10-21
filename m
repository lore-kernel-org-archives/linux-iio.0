Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595726;
	b=PBZP8f0jpTG3c/Xd7D++EPjXv00EooqKc+P0r0YLXjKB3Tuu+RwwNmxCvFtsIJe3lixg
	 pm53UEEZFBHzGezZAG57Zwb6wUuZuptkD9FMPagJ48SwnOLNbA4VsCOhiHNAjd5BfGKFr
	 SxKITArK05ed9MIiNVMnfwv8xLyzmNygXw3fUXyTzBLaU0D6eHd1nIsocl6uGxDLBCifT
	 +RsYPW1taaXA2waeWjpkvtdkleaEu/ZjkY8baUb+8coNLy0vDQLINbzTXYyYlyfg7cfce
	 Rv2CkXuh2g1SL4DPApUeT6Vi9x6gywtnmLB0u1LHs7t4Vj0utxya22v1DhIKxiCC+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=z5QHQniaB8UQJwr12nv8aMFa+4JawJqryd6yJ0w5vOM=;
	b=tMJPa5BdQW7hhiLPy96RH+rukYvKm2zVSVhIYE0ILKFFkcEjWaQ/uD6ejMnfJju1oM7X
	 GM0LdReACFMAQbbbVki6uxxjdQQ8DaA92Qe+8cuRt/rz41YBWDZFQbYHWFCVYXBdse0+N
	 glzIR0M90KFFow+N8d0hUwv1UYs01MoawzCZmMUv+entMisLg6/26QqOGra0gAUKhHT1l
	 fEZtfAzqN5FZSJ+aPbIctomefUspg1+NCjCQbkY2eIipoS4FDL4wmWLPqxYuGmOCRl6sD
	 MIZt4iR3+tIn56EDzkf0qBCv7wvz3cRVifdhU9CDFNukaJSuWhFvlQuVZIT8AsTRWzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=y++LgGgq;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55972606A31A;
	Wed, 21 Oct 2026 15:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55972606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=y++LgGgq
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j8tBj4MNMzlfvpr;
	Wed, 21 Oct 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792595722; x=1795187723; bh=z5QHQniaB8UQJwr12nv8aMFa
	+4JawJqryd6yJ0w5vOM=; b=y++LgGgqLESLWbzLL4BDXwMuzdMCTi6quXI/tx02
	+5lODzpJYJcdJc0hvs8AVjf84xd1M5T5Q5LDbK9qULiJvGBsSClzrwgrd8H/AGWI
	VINiHUx/jpBKVXccBDEpCo8m1LZy7A4L7ziahoFBlHmGBz3uTpxtf29b38Sgq8sJ
	00mQ9GR96Zh2aGaddANM6RVDmdcD9PTCKCJoYGX7iH28ZnKHrrp2T7Pv8Gu9f5Qu
	MjJ2T0sh7Y8eXpnITvnhJ3iTePZBLf/anm9trRDBJ6qFg34Db+jjdMNDxhAE3EqQ
	ya5eYwMZwifIHRiX4OCBMl/hQfwHCYAXtf1oqB1beZPZrQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id daTAItDCxG7f; Wed, 21 Oct 2026 15:15:22 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:e988:4883:8cd6:dc3e] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j8tBd0fQNzlfvpd;
	Wed, 21 Oct 2026 15:15:20 +0000 (UTC)
Message-ID: <3f41338e-fc47-4306-b68b-5a81c26027fe@acm.org>
Date: Wed, 21 Oct 2026 08:15:20 -0700
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on
 mutex helpers
To: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
References: <20261021052435.112686-1-zoone.rupert@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261021052435.112686-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 10:24 PM, Rupesh Majhi wrote:
> Found by building with CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y, which the
> driver does not set today. Build tested only, no hardware here.
Why doesn't this patch set CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y?
Shouldn't that change be included in this patch?

Thanks,

Bart.
