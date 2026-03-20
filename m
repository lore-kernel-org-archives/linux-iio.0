Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C218248873;
	Fri, 20 Mar 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010664; cv=none; b=PWX5VpGV2NofgXIXZ2Wqy+M5yv96YicwxFfsKJbh3zYfDSbXw8+mITEXWzcIUCYi3oiJ7jFdsEvaW89LeHKs5X3bEq0ixU/djAfsnRcmieA6Xv5B2OlkyMalutf9mTj1FC5RbGTplnSotQwhqPMKrb831uIELJUB2YOLkgiJyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010664; c=relaxed/simple;
	bh=LoqdrQ7kBF4E0wfY++rLiGxX3UeGD37vcOsdzMjZ9CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLnXpoAo2cKKu6vWwFErbtbRf++FtT0DqKeavXcMERDX+Gh2NeUym865XJTs3fTUAbcu3j6dHRSEkwQRs3/tAsNn/o4jNtkxu/qSIIW3TSlXAQJPNJJv4EDU20gkUBQdyS5fW+nv8y8+QlOFgvY4mRyJRG1SmP+m8YojsLgqpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpqGIy7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpqGIy7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7BC4CEF7;
	Fri, 20 Mar 2026 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774010663;
	bh=LoqdrQ7kBF4E0wfY++rLiGxX3UeGD37vcOsdzMjZ9CI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qpqGIy7XBVOcu3vsr58F3yIyse1BmYa3hqWqvuQowBnpH9/gofxtqTDBsto+oE9Al
	 /Bcc6I1RlNTlVoM92ONB7CaN/fQUTPmDrm6rucfxQZbX3VyDDdws3Y4u6on3ff0zjH
	 g/U6MJ82uqewn7sDzrmH08jmam8YGr+rJzeEoy3pYncwNHsEPNwiyNa/irK3jhQ7Gm
	 l4ZWs8m5D4Xcl45cQi8woKhwk/UShLHtfrsWexuG9ywM9yhsBzgGUj3r6UgT38eBP2
	 zPllo7BGik6nA2d9JTe9HZ7m0k7NIMp1s97iYdI7ANzfUeM4fuFdDXQtcB/M0qVxvg
	 feF/wKKru6yQQ==
Message-ID: <24bdf87c-1246-46a3-a84a-c1392a82a6bd@kernel.org>
Date: Fri, 20 Mar 2026 13:44:19 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260319190738.151614-1-email@sirat.me>
 <20260319190738.151614-2-email@sirat.me>
 <c71a7cbb-d313-4d42-a487-b5f194d4e9bf@kernel.org>
 <CANn+LWLWiyAo8_+V0EtPyie9AsNZdo+pU2MBhZ1c7im5XhagBA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CANn+LWLWiyAo8_+V0EtPyie9AsNZdo+pU2MBhZ1c7im5XhagBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2026 13:10, Sirat wrote:
> On Fri, Mar 20, 2026 at 3:05 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 19/03/2026 20:07, Siratul Islam wrote:
>>> Add device tree binding documentation for the STMicroelectronics
>>> VL53L1X Time-of-Flight ranging sensor connected via I2C.
>>>
>>> Signed-off-by: Siratul Islam <email@sirat.me>
>>> ---
>>>  .../bindings/iio/proximity/st,vl53l0x.yaml      | 17 +++++++++++++----
>>>  MAINTAINERS                                     |  6 ++++++
>>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>
>> Please read:
>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>>
>> If a tag was not added on purpose, please state why and what changed.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi!
> 
> The vdd-supply requirement and the pin descriptions changed.
> I was not sure if it was a substantial change or not so I did not add
> the tag on purpose.

And this must be stated clearly. I linked a document, please read it.

Best regards,
Krzysztof
