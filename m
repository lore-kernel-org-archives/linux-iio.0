Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997594;
	b=5eWMxyDICP798zEipuOLVrjPlTXiUZPwnYXdtKJcMb7rzv/n1aMM7u99l5L3X5vSknQG
	 WE+SoRwhxi3lqgNalOCmG0APG5Hmd4DO9fhTWg9t9FAGbH0sTDYNTk5eeHZiZ9CoSKdUZ
	 BwZcZ+mzTozEhLw1MJZREEY5yF6+4Hh8HPp6TMHXzt41qEC+8mWl6M58lLUsbyunsxH4T
	 caxAjmD0Vs5V9Paqk49QdGdXd0nGZVsB8E4gMYbheo7CMSmZ9fe1tvG9IK/+a+lxXeNNm
	 m3myggQmIpPcKWmuq6It/vvxhGljk6cAsfa5bVpZzE4HUb7EFdb2hzaMV9CHeu+QbRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997594;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wJrOzcEQroAAuzq1S9zpcuWlXHd3ETBGQmhVYJ/5Neo=;
	b=5eMWSrcjSrp+h5gRrGc/W6jcvUKGooGCv5ljbhfyNV+eqaSWC51TGbQAOK2cWUO7QOCd
	 xcn/Nw4vF3uXBXi4dF4kakzwNPJz+sMTsiC2/7PyP4OFyTy1eSUDhqmSvltrjSrGV6mE+
	 px1xsiN+rFWS//iiJZ+9LZniQ0aH4ZRzCn9pZb0HVjN+cYo8ZpWlcT4pUpesv4BPRqjsJ
	 hFDJMQvv1VoVETn05RIKaVI9g9OOpxuL43UAQ1i+3Bm++fffLoYtz0KEqxVPaU5WMw9g3
	 Vx5BMV0nMVo3mymjtpt10rbf+TItJfyk2sO5+/EmybbdnBQvnW/IJqEntRLcD9kqleA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVgxCtXr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8854606A326;
	Fri,  6 Nov 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVgxCtXr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9FD1F0089F;
	Fri,  6 Nov 2026 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997593;
	bh=wJrOzcEQroAAuzq1S9zpcuWlXHd3ETBGQmhVYJ/5Neo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aVgxCtXrKIKwV8BnPAbg6C+6la+unNBGjIKGvx+9KLlUBqQAXpkd/70UiPVgVgMuU
	 3+QI+vakOCthsK8j83gsY1JRor1AzSMzzfxRHfZY52bAzZzu8QlY+zkyAbSfIGPEzb
	 ZvUazqMRKyeGzrvpvPQtk/X8PKqxLi3z8vx5mHaEvWs3OA0I7Lcei1jwaaJ9nguRv8
	 o3dAtHq9PWJknTdDCMYOi/Op6pED0XiqbzvowCqbc3nrQpsgQzAh/18lsd+tnJq5/C
	 F6PwxZGfM5yCCQqFHUVvmaN/hKYILeFVYwVRQu5SX9LWK44IXvpNA2IaspTLIXBGx9
	 CfzZWcUAPmMOw==
Date: Fri, 6 Nov 2026 14:39:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andy Shevchenko <andy@kernel.org>, jic23@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ad7405: Add
 ADuM7801/7802/7811/7812 support
Message-ID: <179399758998.1528830.11972412583872645520.robh@kernel.org>
References: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
 <20261105093531.7562-2-pop.ioan-daniel@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105093531.7562-2-pop.ioan-daniel@analog.com>


On Thu, 05 Nov 2026 11:35:30 +0200, Pop Ioan Daniel wrote:
> Add compatible strings for the ADuM7801, ADuM7802, ADuM7811 and
> ADuM7812 16-bit isolated sigma-delta modulators.
> 
> The ADuM7801 and ADuM7811 have the same ±320 mV full-scale input range
> as the ADuM7701, and the ADuM7802 and ADuM7812 have the same ±64 mV
> full-scale input range as the ADuM7702. Apart from that, software
> handles them the same way. The ADuM780x support a master clock of up
> to 25 MHz and the ADuM781x of up to 50 MHz, which needs no special
> handling. Use the ADuM7701 and ADuM7702 as fallback compatibles.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - use adi,adum7701 as fallback compatible for ADuM7801/7811 and
>    adi,adum7702 for ADuM7802/7812
> 
>  .../bindings/iio/adc/adi,ad7405.yaml          | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

