Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60F37F332;
	Fri, 21 Aug 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295355; cv=none; b=tl56M9HJigkeXqh8TFnCS9OZ9oJJ/cnYS9u4iizHSjZQImhBfSTtrlImMAsfz3yBEwLUvUpG1A9SNgdMuep/qZVi+0A2ww3QO2egjsGzaUdBCK/13qqxLD2jrAjmY0m4Wqbv53So0441q4YW38SHeLR2f/x/KcOg0NPq9Us0lds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295355; c=relaxed/simple;
	bh=nqKD8nTWpR2PwTyzDiiwNWDY5zm/oInEWYWruItdR+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWqsSCC4No/JJsCByI/hEydXj+ehIxKly0zv9f4Lf78S4WPX6ou/mPTXjJe94l4/ojvQr9MVFy9LZ4MDBcvXfCdFASdDi2C+aX33nHSvmngB+KY+NO0FqADgRiwT4ySgL2BQSCoFa6TCpLGi7FHurCD5sU06yzLfPm6LCRjzfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX1Oq1DM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX1Oq1DM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFF91F000E9;
	Fri, 21 Aug 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295353;
	bh=9tD+sNMBAs6v7WrYmAlxq5ITCc51PXhr98PG+i3gFiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DX1Oq1DMzPCYdJHXmMaAN5IqlyPLbsTg7QP17dRQwm54P6PEGi31AEyllvzG0hKDa
	 0OkFWZweGuTaXYMI0i+1Az7bxZkkFkJ5oB7X8hRNRQ62w6EDUluJUZvqdy1WM5uxhg
	 Rk1lpwtvV+ulxEZsN8PzGjVx/SRx/6hIgaQXSlTSk4XXfMHJ4fp9fKzb8y8tBksdPm
	 MDfH5G2BRiZTFajWP14+UGtkVUkaWdCHqzH7F0RioFlYz7wbiCCX3UOiiAaMVqwBKo
	 MN/Yj9taaQQlsNf9n90bKu8SWUqovoGFLypo3lqKcOuX7nPs1G5aFhvDyXxo4ZnCrk
	 kGbYJN6HyJAMA==
Date: Fri, 21 Aug 2026 08:55:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: light: stk33xx: document the
 Sensortek STK36C61
Message-ID: <20260821-noble-mature-starling-271f9f@quoll>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
 <20260810110423.41697-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810110423.41697-2-jorijnvdgraaf@catcrafts.net>

On Mon, Aug 10, 2026 at 01:04:21PM +0200, Jorijn van der Graaf wrote:
> The STK36C61 is a 3-in-1 ambient light / proximity / RGB colour sensor
> found in the Fairphone 6. Its ambient light and proximity register
> interface is compatible with the stk3310's, while the dedicated
> compatible identifies the part, whose colour channels the fallback
> does not describe.
> 
> Add sensortek,stk36c61 with a sensortek,stk3310 fallback, mirroring
> the stk3013 entry, and widen the title and description to cover the
> part.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

