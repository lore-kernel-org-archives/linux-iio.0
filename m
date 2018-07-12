Return-Path: <SRS0=4FUj=J4=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 4/5] iio:adxl372: Add sampling frequency support
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
 <CAHp75Ve+S7UDyLva_PY4s=cjKoSY+aMfWDUEHb6tp4AxGtGsDg@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4bfc67b7-b062-a8cb-8a30-ccd117d67db9@metafoo.de>
Date: Thu, 12 Jul 2018 20:31:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve+S7UDyLva_PY4s=cjKoSY+aMfWDUEHb6tp4AxGtGsDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 07/12/2018 08:25 PM, Andy Shevchenko wrote:
> On Thu, Jul 12, 2018 at 6:36 PM, Stefan Popa <stefan.popa@analog.com> wrote:
>> This patch adds the option for the user to select the sampling frequency.
>> Also, the user can read the available frequencies and read the currently
>> set frequency via the read_raw function. The frequency can be set via the
>> write_raw function.
>>
>> When the frequency is set, the bandwidth is also checked and ensured
>> that it is constrained to at most half of the sampling frequency.
> 
>> +static int adxl372_find_closest_match(const int *array,
>> +                                     unsigned int size, int val)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < size; i++) {
>> +               if (val <= array[i])
>> +                       return i;
>> +       }
>> +
>> +       return size - 1;
>> +}
> 
> Perhaps it's time to extend bsearch with something called
> bsearch_closest().
> 

While it makes sense to have a helper function for this the generic bsearch
is not a good solution for small arrays. The generated code is probably
larger and the function call overhead of calling the cmp function completely
outweighs the savings from doing a binary search. bsearch() is good if your
array has 100s or 1000s of entries. If it only has 5, not so much.
