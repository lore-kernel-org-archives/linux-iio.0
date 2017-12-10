Return-Path: <SRS0=ER7a=DG=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171210183119.56dd72e1@archlinux>
References: <20171205145559.20294-1-benjamin.gaignard@st.com>
 <CAOFm3uEjyCQoxPOTzQQjPcUoingSTp2Par0ed4eBprpyFWM78w@mail.gmail.com> <20171210183119.56dd72e1@archlinux>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sun, 10 Dec 2017 20:01:41 +0100
Message-ID: <CAOFm3uFhHKm_cFMKc4BVTZeDB8xaUgwdRVUuEVyWbtbK8r1a0A@mail.gmail.com>
Subject: Re: [PATCH] iio: stm32: Adopt SPDX identifier
To: Jonathan Cameron <jic23@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Alexandre Torgue <alexandre.torgue@st.com>, fabrice.gasnier@st.com, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, Benjamin Gaignard" <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sun, Dec 10, 2017 at 7:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 7 Dec 2017 11:10:44 +0100
> Philippe Ombredanne <pombredanne@nexb.com> wrote:
>
>> On Tue, Dec 5, 2017 at 3:55 PM, Benjamin Gaignard
>> <benjamin.gaignard@linaro.org> wrote:
>> > Add SPDX identifier in stm32's files in IIO directory
>> >
>> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Applied.  Philippe please put acks etc here.  Use maintainers
> are a lazy bunch and it's a lot of scrolling ;)
>

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

>
>> > ---
>> >  drivers/iio/adc/stm32-adc-core.c            | 14 +-------------
>> >  drivers/iio/adc/stm32-adc-core.h            | 14 +-------------
>> >  drivers/iio/adc/stm32-adc.c                 | 15 +--------------
>> >  drivers/iio/counter/stm32-lptimer-cnt.c     |  2 +-
>> >  drivers/iio/dac/stm32-dac-core.c            | 14 +-------------
>> >  drivers/iio/dac/stm32-dac-core.h            | 15 +--------------
>> >  drivers/iio/dac/stm32-dac.c                 | 15 +--------------
>> >  drivers/iio/trigger/stm32-lptimer-trigger.c |  3 +--
>> >  drivers/iio/trigger/stm32-timer-trigger.c   |  2 +-
>> >  9 files changed, 9 insertions(+), 85 deletions(-)
>> >
>> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
>> > index 6aefef99f935..40be7d9fadbf 100644
>> > --- a/drivers/iio/adc/stm32-adc-core.c
>> > +++ b/drivers/iio/adc/stm32-adc-core.c
>> > @@ -1,3 +1,4 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * This file is part of STM32 ADC driver
>> >   *
>> > @@ -6,19 +7,6 @@
>> >   *
>> >   * Inspired from: fsl-imx25-tsadc
>> >   *
>> > - * License type: GPLv2
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of the GNU General Public License version 2 as published by
>> > - * the Free Software Foundation.
>> > - *
>> > - * This program is distributed in the hope that it will be useful, but
>> > - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> > - * or FITNESS FOR A PARTICULAR PURPOSE.
>> > - * See the GNU General Public License for more details.
>> > - *
>> > - * You should have received a copy of the GNU General Public License along with
>> > - * this program. If not, see <http://www.gnu.org/licenses/>.
>> >   */
>> >
>> >  #include <linux/clk.h>
>> > diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
>> > index 250ee958a669..8af507b3f32d 100644
>> > --- a/drivers/iio/adc/stm32-adc-core.h
>> > +++ b/drivers/iio/adc/stm32-adc-core.h
>> > @@ -1,22 +1,10 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> >  /*
>> >   * This file is part of STM32 ADC driver
>> >   *
>> >   * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
>> >   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>> >   *
>> > - * License type: GPLv2
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of the GNU General Public License version 2 as published by
>> > - * the Free Software Foundation.
>> > - *
>> > - * This program is distributed in the hope that it will be useful, but
>> > - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> > - * or FITNESS FOR A PARTICULAR PURPOSE.
>> > - * See the GNU General Public License for more details.
>> > - *
>> > - * You should have received a copy of the GNU General Public License along with
>> > - * this program. If not, see <http://www.gnu.org/licenses/>.
>> >   */
>> >
>> >  #ifndef __STM32_ADC_H
>> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> > index c9d96f935dba..f9ccd705bcbb 100644
>> > --- a/drivers/iio/adc/stm32-adc.c
>> > +++ b/drivers/iio/adc/stm32-adc.c
>> > @@ -1,22 +1,9 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * This file is part of STM32 ADC driver
>> >   *
>> >   * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
>> >   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>> > - *
>> > - * License type: GPLv2
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of the GNU General Public License version 2 as published by
>> > - * the Free Software Foundation.
>> > - *
>> > - * This program is distributed in the hope that it will be useful, but
>> > - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> > - * or FITNESS FOR A PARTICULAR PURPOSE.
>> > - * See the GNU General Public License for more details.
>> > - *
>> > - * You should have received a copy of the GNU General Public License along with
>> > - * this program. If not, see <http://www.gnu.org/licenses/>.
>> >   */
>> >
>> >  #include <linux/clk.h>
>> > diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
>> > index 81ae5f74216d..42fb8ba67090 100644
>> > --- a/drivers/iio/counter/stm32-lptimer-cnt.c
>> > +++ b/drivers/iio/counter/stm32-lptimer-cnt.c
>> > @@ -1,3 +1,4 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * STM32 Low-Power Timer Encoder and Counter driver
>> >   *
>> > @@ -7,7 +8,6 @@
>> >   *
>> >   * Inspired by 104-quad-8 and stm32-timer-trigger drivers.
>> >   *
>> > - * License terms:  GNU General Public License (GPL), version 2
>> >   */
>> >
>> >  #include <linux/bitfield.h>
>> > diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
>> > index 55026fe1c610..d0fb3124de07 100644
>> > --- a/drivers/iio/dac/stm32-dac-core.c
>> > +++ b/drivers/iio/dac/stm32-dac-core.c
>> > @@ -1,22 +1,10 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * This file is part of STM32 DAC driver
>> >   *
>> >   * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> >   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>> >   *
>> > - * License type: GPLv2
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of the GNU General Public License version 2 as published by
>> > - * the Free Software Foundation.
>> > - *
>> > - * This program is distributed in the hope that it will be useful, but
>> > - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> > - * or FITNESS FOR A PARTICULAR PURPOSE.
>> > - * See the GNU General Public License for more details.
>> > - *
>> > - * You should have received a copy of the GNU General Public License along with
>> > - * this program. If not, see <http://www.gnu.org/licenses/>.
>> >   */
>> >
>> >  #include <linux/clk.h>
>> > diff --git a/drivers/iio/dac/stm32-dac-core.h b/drivers/iio/dac/stm32-dac-core.h
>> > index daf09931857c..d3b415fb9575 100644
>> > --- a/drivers/iio/dac/stm32-dac-core.h
>> > +++ b/drivers/iio/dac/stm32-dac-core.h
>> > @@ -1,22 +1,9 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> >  /*
>> >   * This file is part of STM32 DAC driver
>> >   *
>> >   * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> >   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>> > - *
>> > - * License type: GPLv2
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of the GNU General Public License version 2 as published by
>> > - * the Free Software Foundation.
>> > - *
>> > - * This program is distributed in the hope that it will be useful, but
>> > - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> > - * or FITNESS FOR A PARTICULAR PURPOSE.
>> > - * See the GNU General Public License for more details.
>> > - *
>> > - * You should have received a copy of the GNU General Public License along with
>> > - * this program. If not, see <http://www.gnu.org/licenses/>.
>> >   */
>> >
>> >  #ifndef __STM32_DAC_CORE_H
>> > diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
>> > index 9ffab02bf9f9..cce26a3a6627 100644
>> > --- a/drivers/iio/dac/stm32-dac.c
>> > +++ b/drivers/iio/dac/stm32-dac.c
>> > @@ -1,23 +1,10 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * This file is part of STM32 DAC driver
>> >   *
>> >   * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> >   * Authors: Amelie Delaunay <amelie.delaunay@st.com>
>> >   *         Fabrice Gasnier <fabrice.gasnier@st.com>
>> > - *
>> > - * License type: GPLv2
>> > - *
>> > - * This program is free software; you can redistribute it and/or modify it
>> > - * under the terms of the GNU General Public License version 2 as published by
>> > - * the Free Software Foundation.
>> > - *
>> > - * This program is distributed in the hope that it will be useful, but
>> > - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> > - * or FITNESS FOR A PARTICULAR PURPOSE.
>> > - * See the GNU General Public License for more details.
>> > - *
>> > - * You should have received a copy of the GNU General Public License along with
>> > - * this program. If not, see <http://www.gnu.org/licenses/>.
>> >   */
>> >
>> >  #include <linux/bitfield.h>
>> > diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
>> > index de361d879929..98cdc7e47f3d 100644
>> > --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
>> > +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
>> > @@ -1,3 +1,4 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * STM32 Low-Power Timer Trigger driver
>> >   *
>> > @@ -5,8 +6,6 @@
>> >   *
>> >   * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
>> >   *
>> > - * License terms:  GNU General Public License (GPL), version 2
>> > - *
>> >   * Inspired by Benjamin Gaignard's stm32-timer-trigger driver
>> >   */
>> >
>> > diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>> > index b542dc484969..ccf1ce653b25 100644
>> > --- a/drivers/iio/trigger/stm32-timer-trigger.c
>> > +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>> > @@ -1,9 +1,9 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> >  /*
>> >   * Copyright (C) STMicroelectronics 2016
>> >   *
>> >   * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
>> >   *
>> > - * License terms:  GNU General Public License (GPL), version 2
>> >   */
>> >
>> >  #include <linux/iio/iio.h>
>> > --
>> > 2.15.0
>> >
>>
>> Thank you for using the simpler SPDX license ids!
>>
>> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
>>
>



-- 
Cordially
Philippe Ombredanne
