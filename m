Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C23D6476;
	Thu,  5 Feb 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297305; cv=none; b=FI8AaYmbQVkQz5FjeZyO5Mf5lm6qQMn94dJ9jPpglEEnrN8Z86o3IGfjKgf58NY/m6Qk039QxH60B3pAdur8i00no/EGQ8wbt9+bOzXr928tyYryQf3lUiIoUYQrgIGUE1PhUNptS61NXW4b9CfvDwtqGYwLZecx/R8zTvTQsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297305; c=relaxed/simple;
	bh=1rHOAdnAwthl1YywQlW1fNO8BlU1Pi+4T0dyzjSTB9g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cEAZa8MT3YEulJ6ptlHlVkF7VrlgcBkFalmTMRieW/aFAh71aryuVQR4NkEQ6RW0bnfAyN8/Jip/s9N38VrkbkBGFu+PDSF00QW1Pc0k07dKg+Qbzc+3L65RxIFssNo+IosHjFnQPuMqgOvXC62+OQ4FVMzKRI6aIOmn7p0IRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DYA3Yq18; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DYA3Yq18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770297301; x=1770902101; i=markus.elfring@web.de;
	bh=jw4Pf1xPC8grSypQIjzZLjkO2G+ExtefqxSRZ3U2IdM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DYA3Yq18OpAOF7y+OmWgzZpM0J3kmJ1MSnusqfA49jZ2M9ok/QpyGoJDQlnvDrS2
	 CnhSk/9llCkF0WYEN8ERALdLAtpc+740P5++L1vq2TtGqhqO3J19DthXF6M27N9S6
	 43NvGvwvYUXyB5Dxi3FndupicgbsQz30DratzJI+u31dFsmGW978tNA4B59z7aobk
	 IVCxfmhSg5fdhRArLE6muWJHjgPa+AQPKp9kelwNrryqv4v+zJ3xIqnFtsYJtmMCf
	 UQEkjil9QCLMj1pL7YvMwcv798nYop/wBnKc5LnmboszjYgBcn8TR4dglLQEC/hqQ
	 ykL1HHjxQCG2pnnXeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.222]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUl9H-1wElG82Ibp-00LBCw; Thu, 05
 Feb 2026 14:15:01 +0100
Message-ID: <ca0c3d9c-eb09-4415-9fa9-b5ba274bd04d@web.de>
Date: Thu, 5 Feb 2026 14:15:00 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chris Spencer <spencercw@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Vasileios Amoiridis <vassilisamir@gmail.com>
References: <20260204133636.29361-1-spencercw@gmail.com>
Subject: Re: [PATCH v2] iio: chemical: bme680: Fix measurement wait duration
 calculation
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260204133636.29361-1-spencercw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JPKExso2StQC9rCa5H+w2q6dPpzhNiXJGuFPuYlPmWv6JL5yrep
 gjcBXyXxtz/wPVVLetlZF/aO2TJv2Cv1lbsi7QAparutTVc6323RSzFjJAkGCjZKylz/IkG
 sKub+UrfPf9YOCMcPeusfvOIonDEc+IKMuSO4vL+zwGNNMpuDEQjjKM7QLBpaI5hRZe/v9H
 Ago07FO0GZZp4pURDD4Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rEzzKpbes2I=;8TiK8pq5X5mQ1lfVrEMtmNzeSZ9
 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
 U2DZvUJ4GRJQvlC/RBQk

=E2=80=A6
> resulting in a wait time that is too short. This can cause the following
> 'device measurement cycle incomplete' check to occasionally fail.

* Were any source code analysis tools involved here?

* See also once more:
  + https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc8#n94

  + https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/stable-kernel-rules.rst?h=3Dv6.19-rc8#n34


Regards,
Markus
