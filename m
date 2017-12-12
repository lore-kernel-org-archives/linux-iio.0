Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38248 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdLLTTt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Dec 2017 14:19:49 -0500
Received: by mail-lf0-f65.google.com with SMTP id e137so24427620lfg.5
        for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2017 11:19:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <13b298c0-d618-e217-406d-63bac56106fc@suse.de>
References: <20171211092002.8687-1-cmo@melexis.com> <13b298c0-d618-e217-406d-63bac56106fc@suse.de>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 12 Dec 2017 20:19:07 +0100
Message-ID: <CAKv63utbAiN3AdR1xRKbHjPeEN2fCGQ8ZocA=T2mKwciqYVfgw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: temperature: add MLX90632 device bindings
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Linux Iio <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12 December 2017 at 18:45, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> Am 11.12.2017 um 10:20 schrieb Crt Mori:
>> Add device tree bindings for MLX90632 IR temperature sensor.
>>
>> Signed-off-by: Crt Mori <cmo@melexis.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/iio/temperature/mlx90632.txt          | 28 +++++++++++++++=
+++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ml=
x90632.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.=
txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
>> new file mode 100644
>> index 000000000000..0b05812001f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> [...]
>> +Example:
>> +
>> +mlx90632@3a {
>
> Shouldn't the node name be more general like temperature@3a?
>

None of the current temperature drivers have that, but it would be
nice for portability. I can prepare a patch to fix them all (a quick
check confirmed it is not consistent in pressure and light as well)

>> +     compatible =3D "melexis,mlx90632";
>> +     reg =3D <0x3a>;
>> +};
>
> Also generally the dt-bindings patch should go before the first use of
> the compatible string.
>

OK, will keep in mind in case of v5 to reorder the commits once again.

Best regards,
Crt
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
