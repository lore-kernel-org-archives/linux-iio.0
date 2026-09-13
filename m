Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030732D42B;
	Sun, 13 Sep 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319136; cv=none; b=ZGLiupGMXlWuEXNMwQKGBLvf/NVdJGn72jrD6TtDI/a6vZ/P5R7TFPWv+GDZft7jumWYULhQ/uIag6OovrdGJbfoqyz9TjyTxbT+wfvKB1E+xFq8oGe3+NBto7fd4WXTe+86iO6zELllgFPPU3a6aj/z0k6EEOQv+AvSboDwbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319136; c=relaxed/simple;
	bh=8xlRaBwM8cW57+Fo4ol+kcDaP+RrVdBKdwCCc8I7+RE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM0PDLp8xNiC5nOicw5kJgJz0s6qgVDQvrgE4dRd6a2Gsx1+5Xg4QSKxP/FtG5aU4XxcWYK4LIj4+rI14mRA2E6QJCWd2lDsmqRKKm8AVkjv9dCtwQu0eRzNDc6jw4Xf21fpDHiYT5iDn5BGNFhAI2zi+I1ZwiG8scwIKTJcPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN6Ubkk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN6Ubkk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BC11F000FF;
	Sun, 13 Sep 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319135;
	bh=6xuouO9/QZf1NH5J2+1X7OYDxnJ2xVuyqYZYPGuUMos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jN6Ubkk/kxJFQla+MDXHA9zCPpO+lsO9aUxwyMxJpnROdqjfsKodiFjzSa6lAnxRS
	 joEW3vRRVziDAB955nz08BWlo9fCfESzvqoalEdtPfodfWPaCewYhfnefQbijGexi+
	 3krVxKBu+HfNo3Z9Sjb6PuJ13vpU7uhSIzgsi9+9sTJZqvA2/4uK3oqjXBJqHaMSzt
	 6eFGzDyU8ToK7TdBGcXNDLcQ1jjBg3oSVoqe6BQwePnP3CRwvaqv3m43AzEAp8poVI
	 +KDLHVIDXTGt72QHvtDigOgrCZc4dZ824GiUHB7xPZGmpjh+zNPFQGGy2j9kfRYeAH
	 23CXRdWCQWjXg==
Date: Sun, 13 Sep 2026 18:05:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, Ramona
 Nechita <ramona.nechita@analog.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, Manivannan Sadhasivam
 <mani@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>, Brian Masney
 <masneyb@onstation.org>, Martyn Welch <martyn.welch@collabora.com>, Rishi
 Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Use consistent indentation in the
 example
Message-ID: <20260913180527.75d0f654@jic23-hlaptop>
In-Reply-To: <20260913123319.100212-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260913123319.100212-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 14:33:20 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Applied, thanks,

J
